//*************************************************************************\
//Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd,All rights reserved
//                     Company  :  ALINX(shanghai) Technology Co.,Ltd
//                      taobao  :  https://oshcn.taobao.com/
//                         WEB  :  http://www.alinx.cn/
//==========================================================================
//   Description: 
//
//   
//==========================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------
//  2017/7/3     guowc          1.0         Original
//*************************************************************************/
#include <linux/module.h>
#include <linux/ratelimit.h>
#include <linux/irq.h>
#include <linux/interrupt.h>
#include <linux/input.h>
#include <linux/i2c.h>
#include <linux/uaccess.h>
#include <linux/delay.h>
#include <linux/debugfs.h>
#include <linux/slab.h>
#include <linux/gpio/consumer.h>
#include <linux/input/mt.h>
#include <linux/input/touchscreen.h>
#include <linux/of_device.h>

#define NO_REGISTER				0xff

#define TOUCH_EVENT_DOWN			0x00
#define TOUCH_EVENT_UP				0x01
#define TOUCH_EVENT_ON				0x02
#define TOUCH_EVENT_RESERVED		0x03

#define EDT_NAME_LEN				23
#define EDT_SWITCH_MODE_RETRIES	10
#define EDT_SWITCH_MODE_DELAY		5 /* msec */
#define EDT_RAW_DATA_RETRIES		100
#define EDT_RAW_DATA_DELAY		1 /* msec */

#define MAX_SUPPORT_POINTS        1

#define SCREEN_MAX_X               800
#define SCREEN_MAX_Y               480


#define AUO_PIXCIR_MAX_AREA		0xff

#define ALINX_READ_COOR_ADDR		0x814E


struct alinx_ts_data {
	struct i2c_client *client;
	struct input_dev *input;
	int num_x;
	int num_y;

	struct gpio_desc *reset_gpio;
	struct mutex mutex;
	int threshold;
	int gain;
	int offset;
	int report_rate;
	int max_support_points;

	char name[EDT_NAME_LEN];
};

struct edt_i2c_chip_data {
	int  max_support_points;
};

static int alinx_ts_readwrite(struct i2c_client *client,
				   u16 wr_len, u8 *wr_buf,
				   u16 rd_len, u8 *rd_buf)
{


	struct i2c_msg wrmsg[2];
	int i = 0;
	int ret;

	if (wr_len) {
		wrmsg[i].addr  = client->addr;
		wrmsg[i].flags = 0;
		wrmsg[i].len = wr_len;
		wrmsg[i].buf = wr_buf;
		i++;
	}
	if (rd_len) {
		wrmsg[i].addr  = client->addr;
		wrmsg[i].flags = I2C_M_RD;
		wrmsg[i].len = rd_len;
		wrmsg[i].buf = rd_buf;
		i++;
	}


	ret = i2c_transfer(client->adapter, wrmsg, i);
	if (ret < 0)
		return ret;
	if (ret != i)
		return -EIO;

	int nret = ret < 0 ? ret : (ret != ARRAY_SIZE(wrmsg) ? -EIO : 0);

	return 0;
}


static irqreturn_t alinx_ts_isr(int irq, void *dev_id)
{
	
	struct alinx_ts_data *ts = dev_id;

	disable_irq_nosync(irq);

	struct device *dev = &ts->client->dev;
	u8 cmd;
	u8 rdbuf[63];
	int i,offset, tplen, datalen, crclen;
	int error;
	u32 id, x, y, status, num_touches;
	bool update_input = false;

	u32 gestid;

	cmd = 0x0;
	offset = 3;
	tplen = 6;
	crclen = 0;

	if(!ts)
		goto out;		

	memset(rdbuf, 0, sizeof(rdbuf));
	datalen = tplen + offset + crclen;


	error = alinx_ts_readwrite(ts->client,
					sizeof(cmd), &cmd,
					datalen, rdbuf);
	if (error) {
		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
				    error);
		goto out;
	}

	u8 *gbuf = &rdbuf[1];
	gestid = gbuf[0] & 0xff;


	u8 *xbuf = &rdbuf[2];
	num_touches = xbuf[0] & 0x0f;
	
	u8 *buf = &rdbuf[offset];
	status = buf[0] >> 6;
	if (status == TOUCH_EVENT_RESERVED)
		goto out;

	x = ((buf[0] << 8) | buf[1]) & 0x0fff;
	y = ((buf[2] << 8) | buf[3]) & 0x0fff;
	id = (buf[2] >> 4) & 0x0f;


	if (status!=TOUCH_EVENT_UP) 
	{
		input_report_abs(ts->input, ABS_X, x);
		input_report_abs(ts->input, ABS_Y, y);
		input_event(ts->input, EV_KEY, BTN_TOUCH, 1);
		input_report_abs(ts->input, ABS_PRESSURE, 1);
	}
	else
	{
		input_report_key(ts->input, BTN_TOUCH, 0);
		input_report_abs(ts->input, ABS_PRESSURE, 0);
	}

	input_sync(ts->input);

out:
	enable_irq(irq);   

	return IRQ_HANDLED;
}

static int alinx_register_write(struct alinx_ts_data *tsdata,
				     u8 addr, u8 value)
{

	u8 wrbuf[4];

	wrbuf[0] = addr;
	wrbuf[1] = value;

	return alinx_ts_readwrite(tsdata->client, 2,
				wrbuf, 0, NULL);
}

static int alinx_register_read(struct alinx_ts_data *tsdata,
				    u8 addr)
{

	u8 wrbuf[2], rdbuf[2];
	int error;

	wrbuf[0] = addr;
	error = alinx_ts_readwrite(tsdata->client, 1,
					wrbuf, 1, rdbuf);
	if (error)
		return error;

	return rdbuf[0];
}


static int alinx_ts_identify(struct i2c_client *client,
					struct alinx_ts_data *tsdata,
					char *fw_version)
{


	u8 rdbuf[EDT_NAME_LEN];
	char *p;
	int error;
	char *model_name = tsdata->name;

	memset(rdbuf, 0, sizeof(rdbuf));
	error = alinx_ts_readwrite(client, 1, "\xbb",
					EDT_NAME_LEN - 1, rdbuf);
	if (error)
		return error;

	error = alinx_ts_readwrite(client, 1, "\xA6",
					2, rdbuf);
	if (error)
		return error;

	strlcpy(fw_version, rdbuf, 2);

	error = alinx_ts_readwrite(client, 1, "\xA8",
					1, rdbuf);
	if (error)
		return error;

	snprintf(model_name, EDT_NAME_LEN, "EP0%i%i0M09",
		rdbuf[0] >> 4, rdbuf[0] & 0x0F);


	return 0;
}

static int alinx_ts_enable(struct i2c_client *client)
{
	u8 buf[2] = { 0x00, 0x11 };
	int ret;

	ret = i2c_master_send(client, buf, 2);

	if (ret < 0)
	{
		return ret;
	}

	return 0;
}


static int alinx_ts_probe(struct i2c_client *client,
					 const struct i2c_device_id *id)
{


	struct alinx_ts_data *tsdata;
	struct input_dev *input;
	unsigned long irq_flags;
	int error;
	char fw_version[EDT_NAME_LEN];

	dev_dbg(&client->dev, "probing for Alinx I2C\n");



	tsdata = devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
	if (!tsdata) {
		dev_err(&client->dev, "failed to allocate driver data.\n");
		return -ENOMEM;
	}

	tsdata->max_support_points = MAX_SUPPORT_POINTS;


	input = devm_input_allocate_device(&client->dev);
	if (!input) {
		dev_err(&client->dev, "failed to allocate input device.\n");
		error -ENOMEM;
		goto err_free_mem;
	}

//	mutex_init(&tsdata->mutex);
	tsdata->client = client;
	tsdata->input = input;
	
	error = alinx_ts_identify(client, tsdata, fw_version);
	if (error) {
		dev_err(&client->dev, "touchscreen probe failed\n");
		goto err_free_mem;
	}

	input->name = tsdata->name;
	input->id.bustype = BUS_I2C;
	input->phys = "I2C";
	input->dev.parent = &client->dev;


	__set_bit(EV_ABS, input->evbit);
	__set_bit(EV_KEY, input->evbit);
	__set_bit(EV_SYN, input->evbit);
	__set_bit(BTN_TOUCH, input->keybit);
	__set_bit(ABS_X, input->absbit);
	__set_bit(ABS_Y, input->absbit);
	__set_bit(ABS_PRESSURE, input->absbit);
	input_set_abs_params(input, ABS_X, 0, SCREEN_MAX_X, 0, 0);
	input_set_abs_params(input, ABS_Y, 0, SCREEN_MAX_Y, 0, 0);


	input_set_drvdata(input, tsdata);
	i2c_set_clientdata(client, tsdata);


	error = input_register_device(input);
	if (error)
		goto err_free_mem;

	irq_flags = irq_get_trigger_type(client->irq);
	if (irq_flags == IRQF_TRIGGER_NONE)
		irq_flags = IRQF_TRIGGER_HIGH;
	irq_flags |= IRQF_ONESHOT;

	error = devm_request_threaded_irq(&client->dev, client->irq,
					NULL, alinx_ts_isr, irq_flags,
					client->name, tsdata);
	if (error) {
		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
		goto err_free_mem;
	}

	return 0;

err_free_irq:
	free_irq(client->irq, tsdata);
err_free_mem:
	input_free_device(input);
	kfree(tsdata);
	
	
	return error;
}

static int alinx_ts_remove(struct i2c_client *client)
{
	const struct alinx_platform_data *pdata = dev_get_platdata(&client->dev);

	struct alinx_ts_data *tsdata = i2c_get_clientdata(client);


	free_irq(client->irq, tsdata);
	input_unregister_device(tsdata->input);

	kfree(tsdata);

	return 0;
}

static int __maybe_unused alinx_ts_suspend(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);

	if (device_may_wakeup(dev))
		enable_irq_wake(client->irq);

	return 0;
}

static int __maybe_unused alinx_ts_resume(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);

	if (device_may_wakeup(dev))
		disable_irq_wake(client->irq);

	return 0;
}

static SIMPLE_DEV_PM_OPS(alinx_ts_pm_ops,
			 alinx_ts_suspend, alinx_ts_resume);


static const struct edt_i2c_chip_data alinx_data = {
	.max_support_points = 5,
};


static const struct i2c_device_id alinx_ts_id[] = {
	{ .name = "alinx",  .driver_data = (long)&alinx_data },
	{}
};
MODULE_DEVICE_TABLE(i2c, alinx_ts_id);


static const struct of_device_id alinx_of_match[] = {
	{ .compatible = "alinx,an071", .data = &alinx_data },
	{}

};
MODULE_DEVICE_TABLE(of, alinx_of_match);


static struct i2c_driver alinx_ts_driver = {
	.driver = {
		.owner  = THIS_MODULE,
		.name   = "alinx",
		.of_match_table = of_match_ptr(alinx_of_match),
		.pm 	= &alinx_ts_pm_ops,
	},
	.id_table = alinx_ts_id,
	.probe    = alinx_ts_probe,
	.remove   = alinx_ts_remove,
};

module_i2c_driver(alinx_ts_driver);

MODULE_AUTHOR("guowc");
MODULE_DESCRIPTION("Alinx I2C Touchscreen Driver");
MODULE_LICENSE("GPL");





