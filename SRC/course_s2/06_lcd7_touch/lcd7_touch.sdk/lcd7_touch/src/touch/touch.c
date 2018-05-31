#include "xparameters.h"

#include "xscugic.h"

#include "xil_exception.h"

#include "xgpio.h"

#include "touch.h"


#include "xiicps.h"
#include "../i2c/PS_i2c.h"

XIicPs IicInstance;


#ifdef XPAR_INTC_0_DEVICE_ID
 #include "xintc.h"
#else
 #include "xscugic.h"
#endif

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */


// Parameter definitions
#define IIC_DEVICE_ID	XPAR_XIICPS_0_DEVICE_ID

#define TOUCH_INT_DEVICE_ID     XPAR_GPIO_0_DEVICE_ID

#define INTC_GPIO_INTERRUPT_ID  XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR

#define TOUCH_INT               XGPIO_IR_CH1_MASK // This is the interrupt mask for channel one

#define TOUCH_ADDRESS 		0x38	/* 0xA0 as an 8 bit number. */

XGpio   Touch_Gpio_Inst;

u8 WriteBuffer[20];	/* Read buffer for reading a page. */


void Touch_Intr_Handler(void *InstancePtr);
int touch_init (void);


/*****************************************************************************/
/**
* This function read bytes from IIC device*
*
******************************************************************************/
int touch_i2c_read_bytes(u8 *BufferPtr, u8 address, u16 ByteCount)
{

	u8 buf[2];
	buf[0] = address;
	if(i2c_wrtie_bytes(&IicInstance,TOUCH_ADDRESS,buf,1) != XST_SUCCESS)
		return XST_FAILURE;
	if(i2c_read_bytes(&IicInstance,TOUCH_ADDRESS,BufferPtr,ByteCount) != XST_SUCCESS)
			return XST_FAILURE;
	return XST_SUCCESS;
}

int touch_init (void)
{
	int status;
	// 初始化GPIO
	status = XGpio_Initialize(&Touch_Gpio_Inst, TOUCH_INT_DEVICE_ID);
	if(status != XST_SUCCESS) return XST_FAILURE;
	// 设置Touch int IO的方向为输入
	XGpio_SetDataDirection(&Touch_Gpio_Inst, 1, 0xFF);
	XGpio_InterruptEnable(&Touch_Gpio_Inst, 1);
	XGpio_InterruptGlobalEnable(&Touch_Gpio_Inst);
	InterruptConnect(XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR,(void *)&Touch_Gpio_Inst,Touch_Intr_Handler);
	i2c_init(&IicInstance, IIC_DEVICE_ID,100000);
	return XST_SUCCESS;

}

void Touch_Intr_Handler(void *InstancePtr)

{
	static u8 Touch_int_value;
	// Ignore additional button presses
	if ((XGpio_InterruptGetStatus(&Touch_Gpio_Inst) & TOUCH_INT) != TOUCH_INT) {
		return;
	}
	// Disable GPIO interrupts
	XGpio_InterruptDisable(&Touch_Gpio_Inst, TOUCH_INT);

	Touch_int_value = XGpio_DiscreteRead(&Touch_Gpio_Inst, 1) & 0x01;//检测触摸屏的中断信号
    if(Touch_int_value == 0) {
    	touch_sig = 1;
    }
    // Acknowledge GPIO interrupts
    XGpio_InterruptClear(&Touch_Gpio_Inst, TOUCH_INT);
    // Enable GPIO interrupts
    XGpio_InterruptEnable(&Touch_Gpio_Inst, TOUCH_INT);
}


