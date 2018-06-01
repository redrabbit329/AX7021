/*
 * ax_lcd_encoder.c - DRM slave encoder for ALINX AN071
 *
 * Copyright (C) 2017 ALINX
 * Author: guowc
 *
 * Based on udl_encoder.c and udl_connector.c, Copyright (C) 2012 Red Hat.
 * Also based on xilinx_drm_dp.c, Copyright (C) 2014 Xilinx, Inc.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 */
 
#include <drm/drmP.h>
#include <drm/drm_edid.h>
#include <drm/drm_encoder_slave.h>

#include <linux/device.h>
#include <linux/module.h>
#include <linux/err.h>
#include <linux/i2c.h>
#include <linux/of.h>
#include <linux/of_platform.h>
#include <linux/platform_device.h>



struct ax_lcd_encoder {
	struct drm_encoder *encoder;
};
static const struct drm_display_mode lcd_mode = {
	.clock = 33260,
	.hdisplay = 800,
	.hsync_start = 800 + 40,
	.hsync_end = 800 + 40 + 128,
	.htotal = 800 + 40 + 128 + 88,
	.vdisplay = 480,
	.vsync_start = 480 + 10,
	.vsync_end = 480 + 10 + 2,
	.vtotal = 480 + 10 + 2 + 33,
	.vrefresh = 60,
	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
};

static inline struct ax_lcd_encoder *to_ax_lcd_encoder(struct drm_encoder *encoder)
{
	return to_encoder_slave(encoder)->slave_priv;
}

static bool ax_lcd_mode_fixup(struct drm_encoder *encoder,
			   const struct drm_display_mode *mode,
			   struct drm_display_mode *adjusted_mode)
{
	return true;
}

static void ax_lcd_encoder_mode_set(struct drm_encoder *encoder,
				 struct drm_display_mode *mode,
				 struct drm_display_mode *adjusted_mode)
{
}

static void
ax_lcd_encoder_dpms(struct drm_encoder *encoder, int mode)
{
}

static void ax_lcd_encoder_save(struct drm_encoder *encoder)
{
}

static void ax_lcd_encoder_restore(struct drm_encoder *encoder)
{
}

static int ax_lcd_encoder_mode_valid(struct drm_encoder *encoder,
				    struct drm_display_mode *mode)
{
	return MODE_OK;
}

static int ax_lcd_encoder_get_modes(struct drm_encoder *encoder,
				   struct drm_connector *connector)
{
   struct ax_lcd_encoder *ax_lcd = to_ax_lcd_encoder(encoder);
	struct edid *edid;
   struct drm_display_mode *mode;
   int num_modes = 0;
   
   {
         mode = drm_mode_duplicate(encoder->dev, &lcd_mode);
         mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
         drm_mode_set_name(mode);
         drm_mode_probed_add(connector, mode);
         num_modes++;

   }   
	return num_modes;
}

static enum drm_connector_status ax_lcd_encoder_detect(struct drm_encoder *encoder,
		     struct drm_connector *connector)
{
   struct ax_lcd_encoder *ax_lcd = to_ax_lcd_encoder(encoder);

   return connector_status_connected; 
}

static struct drm_encoder_slave_funcs ax_lcd_encoder_slave_funcs = {
	.dpms 			= ax_lcd_encoder_dpms,
	.save			= ax_lcd_encoder_save,
	.restore		= ax_lcd_encoder_restore,
	.mode_fixup 	= ax_lcd_mode_fixup,
	.mode_valid		= ax_lcd_encoder_mode_valid,
	.mode_set 		= ax_lcd_encoder_mode_set,
	.detect			= ax_lcd_encoder_detect,
	.get_modes		= ax_lcd_encoder_get_modes,
};

static int ax_lcd_encoder_encoder_init(struct platform_device *pdev,
				      struct drm_device *dev,
				      struct drm_encoder_slave *encoder)
{
	struct ax_lcd_encoder *ax_lcd = platform_get_drvdata(pdev);
	struct device_node *sub_node;

	encoder->slave_priv = ax_lcd;
	encoder->slave_funcs = &ax_lcd_encoder_slave_funcs;

	ax_lcd->encoder = &encoder->base;

	return 0;
}

static int ax_lcd_encoder_probe(struct platform_device *pdev)
{
	struct ax_lcd_encoder *ax_lcd;

	ax_lcd = devm_kzalloc(&pdev->dev, sizeof(*ax_lcd), GFP_KERNEL);
	if (!ax_lcd)
		return -ENOMEM;

	platform_set_drvdata(pdev, ax_lcd);

	return 0;
}

static int ax_lcd_encoder_remove(struct platform_device *pdev)
{
	return 0;
}

static const struct of_device_id ax_lcd_encoder_of_match[] = {
	{ .compatible = "ax_lcd,drm-encoder", },
	{ /* end of table */ },
};
MODULE_DEVICE_TABLE(of, ax_lcd_encoder_of_match);

static struct drm_platform_encoder_driver ax_lcd_encoder_driver = {
	.platform_driver = {
		.probe			= ax_lcd_encoder_probe,
		.remove			= ax_lcd_encoder_remove,
		.driver			= {
			.owner		= THIS_MODULE,
			.name		= "ax_lcd-drm-enc",
			.of_match_table	= ax_lcd_encoder_of_match,
			},
	},

	.encoder_init = ax_lcd_encoder_encoder_init,
};

static int __init ax_lcd_encoder_init(void)
{
	return platform_driver_register(&ax_lcd_encoder_driver.platform_driver);
}

static void __exit ax_lcd_encoder_exit(void)
{
	platform_driver_unregister(&ax_lcd_encoder_driver.platform_driver);
}

module_init(ax_lcd_encoder_init);
module_exit(ax_lcd_encoder_exit);

MODULE_AUTHOR("");
MODULE_DESCRIPTION("DRM slave encoder for ALINX AN071");
MODULE_LICENSE("GPL v2");
