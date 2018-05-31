vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/processing_system7_bfm_v2_0_5
vlib riviera/lib_cdc_v1_0_2
vlib riviera/lib_pkg_v1_0_2
vlib riviera/fifo_generator_v13_1_3
vlib riviera/lib_fifo_v1_0_7
vlib riviera/blk_mem_gen_v8_3_5
vlib riviera/lib_bmg_v1_0_7
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/axi_datamover_v5_1_13
vlib riviera/axi_vdma_v6_2_10
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/v_tc_v6_1_10
vlib riviera/v_vid_in_axi4s_v4_0_5
vlib riviera/v_axi4s_vid_out_v4_0_5
vlib riviera/interrupt_control_v3_1_4
vlib riviera/axi_gpio_v2_0_13
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/axis_register_slice_v1_1_11
vlib riviera/axis_subset_converter_v1_1_11
vlib riviera/proc_sys_reset_v5_0_10
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_11
vlib riviera/axi_data_fifo_v2_1_10
vlib riviera/axi_crossbar_v2_1_12
vlib riviera/axi_protocol_converter_v2_1_11

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap processing_system7_bfm_v2_0_5 riviera/processing_system7_bfm_v2_0_5
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap fifo_generator_v13_1_3 riviera/fifo_generator_v13_1_3
vmap lib_fifo_v1_0_7 riviera/lib_fifo_v1_0_7
vmap blk_mem_gen_v8_3_5 riviera/blk_mem_gen_v8_3_5
vmap lib_bmg_v1_0_7 riviera/lib_bmg_v1_0_7
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_13 riviera/axi_datamover_v5_1_13
vmap axi_vdma_v6_2_10 riviera/axi_vdma_v6_2_10
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_10 riviera/v_tc_v6_1_10
vmap v_vid_in_axi4s_v4_0_5 riviera/v_vid_in_axi4s_v4_0_5
vmap v_axi4s_vid_out_v4_0_5 riviera/v_axi4s_vid_out_v4_0_5
vmap interrupt_control_v3_1_4 riviera/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_13 riviera/axi_gpio_v2_0_13
vmap axis_infrastructure_v1_1_0 riviera/axis_infrastructure_v1_1_0
vmap axis_register_slice_v1_1_11 riviera/axis_register_slice_v1_1_11
vmap axis_subset_converter_v1_1_11 riviera/axis_subset_converter_v1_1_11
vmap proc_sys_reset_v5_0_10 riviera/proc_sys_reset_v5_0_10
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_11 riviera/axi_register_slice_v2_1_11
vmap axi_data_fifo_v2_1_10 riviera/axi_data_fifo_v2_1_10
vmap axi_crossbar_v2_1_12 riviera/axi_crossbar_v2_1_12
vmap axi_protocol_converter_v2_1_11 riviera/axi_protocol_converter_v2_1_11

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"D:/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work processing_system7_bfm_v2_0_5  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl/processing_system7_bfm_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/832a/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_1_3  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/564d/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_3 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/564d/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_3  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/564d/hdl/fifo_generator_v13_1_rfs.v" \

vcom -work lib_fifo_v1_0_7 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/5ab6/hdl/lib_fifo_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_3_5  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/6273/simulation/blk_mem_gen_v8_3.v" \

vcom -work lib_bmg_v1_0_7 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/38e8/hdl/lib_bmg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/6039/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_13 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/bf41/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vlog -work axi_vdma_v6_2_10  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl/axi_vdma_v6_2_rfs.v" \

vcom -work axi_vdma_v6_2_10 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl/axi_vdma_v6_2_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_axi_vdma_0_0/sim/system_axi_vdma_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/0ba0/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_10 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/d9f8/hdl/v_tc_v6_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_v_tc_0_0/sim/system_v_tc_0_0.vhd" \

vlog -work v_vid_in_axi4s_v4_0_5  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/3c71/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_5  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/1923/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_v_axi4s_vid_out_0_0/sim/system_v_axi4s_vid_out_0_0.v" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/9097/src/mmcme2_drp.v" \

vcom -work xil_defaultlib -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/9097/src/axi_dynclk_S00_AXI.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/9097/src/axi_dynclk.vhd" \
"../../../bd/system/ip/system_axi_dynclk_0_0/sim/system_axi_dynclk_0_0.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/ClockGen.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/SyncAsync.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/SyncAsyncReset.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/DVI_Constants.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/OutputSERDES.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/TMDS_Encoder.vhd" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/24a6/src/rgb2dvi.vhd" \
"../../../bd/system/ip/system_rgb2dvi_0_0/sim/system_rgb2dvi_0_0.vhd" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/e956/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_13 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/4f16/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_axi_gpio_0_0/sim/system_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ipshared/e147/xlconstant.v" \
"../../../bd/system/ip/system_xlconstant_0_0/sim/system_xlconstant_0_0.v" \

vlog -work axis_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_register_slice_v1_1_11  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/09aa/hdl/axis_register_slice_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tdata_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tuser_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tstrb_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tkeep_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tid_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tdest_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/tlast_system_axis_subset_converter_0_0.v" \

vlog -work axis_subset_converter_v1_1_11  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/8a5f/hdl/axis_subset_converter_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/hdl/top_system_axis_subset_converter_0_0.v" \
"../../../bd/system/ip/system_axis_subset_converter_0_0/sim/system_axis_subset_converter_0_0.v" \
"../../../bd/system/ipshared/2e37/xlconcat.v" \
"../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \

vcom -work proc_sys_reset_v5_0_10 -93 \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/04b4/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_rst_processing_system7_0_140M_0/sim/system_rst_processing_system7_0_140M_0.vhd" \
"../../../bd/system/ip/system_rst_processing_system7_0_100M_0/sim/system_rst_processing_system7_0_100M_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_xlconstant_1_0/sim/system_xlconstant_1_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7ee0/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_11  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/0b6b/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_10  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/39ba/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_12  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/896d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_xbar_0/sim/system_xbar_0.v" \

vlog -work axi_protocol_converter_v2_1_11  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/df1b/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7dd0/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/ed72/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/fe67/hdl" "+incdir+../../../../TF_image_display.srcs/sources_1/bd/system/ipshared/7e3a/hdl" \
"../../../bd/system/ip/system_auto_pc_0/sim/system_auto_pc_0.v" \
"../../../bd/system/ip/system_auto_pc_1/sim/system_auto_pc_1.v" \
"../../../bd/system/hdl/system.v" \

vlog -work xil_defaultlib "glbl.v"

