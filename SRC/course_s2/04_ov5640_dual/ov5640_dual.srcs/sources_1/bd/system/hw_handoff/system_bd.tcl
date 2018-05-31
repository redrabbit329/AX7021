
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-2

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set HDMI_I2C [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_I2C ]
  set hdmi_nreset [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 hdmi_nreset ]

  # Create ports
  set cmos1_d [ create_bd_port -dir I -from 9 -to 0 cmos1_d ]
  set cmos1_href [ create_bd_port -dir I cmos1_href ]
  set cmos1_pclk [ create_bd_port -dir I cmos1_pclk ]
  set cmos1_reset [ create_bd_port -dir O cmos1_reset ]
  set cmos1_scl [ create_bd_port -dir IO cmos1_scl ]
  set cmos1_sda [ create_bd_port -dir IO cmos1_sda ]
  set cmos1_vsync [ create_bd_port -dir I cmos1_vsync ]
  set cmos2_d [ create_bd_port -dir I -from 9 -to 0 cmos2_d ]
  set cmos2_href [ create_bd_port -dir I cmos2_href ]
  set cmos2_pclk [ create_bd_port -dir I cmos2_pclk ]
  set cmos2_reset [ create_bd_port -dir O cmos2_reset ]
  set cmos2_scl [ create_bd_port -dir IO cmos2_scl ]
  set cmos2_sda [ create_bd_port -dir IO cmos2_sda ]
  set cmos2_vsync [ create_bd_port -dir I cmos2_vsync ]
  set hdmi_clk [ create_bd_port -dir O -type clk hdmi_clk ]
  set hdmi_d [ create_bd_port -dir O -from 23 -to 0 hdmi_d ]
  set hdmi_de [ create_bd_port -dir O hdmi_de ]
  set hdmi_hs [ create_bd_port -dir O hdmi_hs ]
  set hdmi_vs [ create_bd_port -dir O hdmi_vs ]

  # Create instance: alinx_ov5640_RGB565_0, and set properties
  set alinx_ov5640_RGB565_0 [ create_bd_cell -type ip -vlnv www.alinx.com.cn:user:alinx_ov5640_RGB565:2.1 alinx_ov5640_RGB565_0 ]

  # Create instance: alinx_ov5640_RGB565_1, and set properties
  set alinx_ov5640_RGB565_1 [ create_bd_cell -type ip -vlnv www.alinx.com.cn:user:alinx_ov5640_RGB565:2.1 alinx_ov5640_RGB565_1 ]

  # Create instance: axi_dynclk_0, and set properties
  set axi_dynclk_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:axi_dynclk:1.0 axi_dynclk_0 ]

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_GPIO_WIDTH {1} \
 ] $axi_gpio_0

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_mem_intercon

  # Create instance: axi_mem_intercon1, and set properties
  set axi_mem_intercon1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_mem_intercon1

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s_dre {1} \
CONFIG.c_include_s2mm {0} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {128} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
 ] $axi_vdma_0

  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_1 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s {0} \
CONFIG.c_include_s2mm_dre {1} \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {128} \
CONFIG.c_use_s2mm_fsync {2} \
 ] $axi_vdma_1

  # Create instance: axi_vdma_2, and set properties
  set axi_vdma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_2 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s_dre {1} \
CONFIG.c_include_s2mm {0} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {128} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
 ] $axi_vdma_2

  # Create instance: axi_vdma_3, and set properties
  set axi_vdma_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_3 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s {0} \
CONFIG.c_include_s2mm_dre {1} \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {128} \
CONFIG.c_use_s2mm_fsync {2} \
 ] $axi_vdma_3

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {1} \
CONFIG.M_HAS_TLAST {1} \
CONFIG.M_TDATA_NUM_BYTES {3} \
CONFIG.M_TUSER_WIDTH {1} \
CONFIG.S_HAS_TKEEP {1} \
CONFIG.S_HAS_TLAST {1} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TUSER_WIDTH {1} \
CONFIG.TDATA_REMAP {tdata[23:0]} \
CONFIG.TKEEP_REMAP {tkeep[2:0]} \
CONFIG.TLAST_REMAP {tlast[0]} \
CONFIG.TUSER_REMAP {tuser[0:0]} \
 ] $axis_subset_converter_0

  # Create instance: axis_subset_converter_1, and set properties
  set axis_subset_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_1 ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {1} \
CONFIG.M_HAS_TLAST {1} \
CONFIG.M_TDATA_NUM_BYTES {3} \
CONFIG.M_TUSER_WIDTH {1} \
CONFIG.S_HAS_TKEEP {1} \
CONFIG.S_HAS_TLAST {1} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TUSER_WIDTH {1} \
CONFIG.TDATA_REMAP {tdata[23:0]} \
CONFIG.TKEEP_REMAP {tkeep[2:0]} \
CONFIG.TLAST_REMAP {tlast[0]} \
CONFIG.TUSER_REMAP {tuser[0:0]} \
 ] $axis_subset_converter_1

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {767} \
CONFIG.PCW_ENET0_ENET0_IO {<Select>} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {24} \
CONFIG.PCW_I2C0_I2C0_IO {EMIO} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_1_SLEW {fast} \
CONFIG.PCW_MIO_2_SLEW {fast} \
CONFIG.PCW_MIO_3_SLEW {fast} \
CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_SLEW {fast} \
CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_SLEW {fast} \
CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_SLEW {fast} \
CONFIG.PCW_MIO_46_SLEW {fast} \
CONFIG.PCW_MIO_47_SLEW {fast} \
CONFIG.PCW_MIO_48_SLEW {fast} \
CONFIG.PCW_MIO_49_SLEW {fast} \
CONFIG.PCW_MIO_4_SLEW {fast} \
CONFIG.PCW_MIO_50_SLEW {fast} \
CONFIG.PCW_MIO_51_SLEW {fast} \
CONFIG.PCW_MIO_5_SLEW {fast} \
CONFIG.PCW_MIO_6_SLEW {fast} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 10} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD1_SD1_IO {MIO 46 .. 51} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 12 .. 13} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB0_USB0_IO {<Select>} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {1} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {7} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: rst_processing_system7_0_150M, and set properties
  set rst_processing_system7_0_150M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_150M ]

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_S_AXIS_VIDEO_DATA_WIDTH {8} \
CONFIG.C_S_AXIS_VIDEO_FORMAT {2} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_osd_0, and set properties
  set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd:6.0 v_osd_0 ]
  set_property -dict [ list \
CONFIG.BG_COLOR0 {255} \
CONFIG.BG_COLOR1 {0} \
CONFIG.BG_COLOR2 {0} \
CONFIG.Data_Channel_Width {8} \
CONFIG.HAS_AXI4_LITE {false} \
CONFIG.LAYER0_ENABLE {true} \
CONFIG.LAYER0_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER0_HEIGHT {720} \
CONFIG.LAYER0_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER0_PRIORITY {0} \
CONFIG.LAYER0_VERTICAL_START_POSITION {0} \
CONFIG.LAYER0_WIDTH {1280} \
CONFIG.LAYER1_ENABLE {true} \
CONFIG.LAYER1_GLOBAL_ALPHA_ENABLE {true} \
CONFIG.LAYER1_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER1_HEIGHT {720} \
CONFIG.LAYER1_HORIZONTAL_START_POSITION {640} \
CONFIG.LAYER1_PRIORITY {1} \
CONFIG.LAYER1_VERTICAL_START_POSITION {360} \
CONFIG.LAYER1_WIDTH {1280} \
CONFIG.LAYER2_ENABLE {false} \
CONFIG.LAYER2_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER2_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER2_HEIGHT {720} \
CONFIG.LAYER2_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER2_PRIORITY {1} \
CONFIG.LAYER2_VERTICAL_START_POSITION {0} \
CONFIG.LAYER2_WIDTH {1280} \
CONFIG.LAYER3_ENABLE {false} \
CONFIG.LAYER3_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER3_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER3_HEIGHT {720} \
CONFIG.LAYER3_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER3_PRIORITY {1} \
CONFIG.LAYER3_VERTICAL_START_POSITION {0} \
CONFIG.LAYER3_WIDTH {1280} \
CONFIG.LAYER4_ENABLE {false} \
CONFIG.LAYER4_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER4_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER4_HEIGHT {720} \
CONFIG.LAYER4_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER4_PRIORITY {1} \
CONFIG.LAYER4_VERTICAL_START_POSITION {0} \
CONFIG.LAYER4_WIDTH {1280} \
CONFIG.LAYER5_ENABLE {false} \
CONFIG.LAYER5_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER5_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER5_HEIGHT {720} \
CONFIG.LAYER5_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER5_PRIORITY {1} \
CONFIG.LAYER5_VERTICAL_START_POSITION {0} \
CONFIG.LAYER5_WIDTH {1280} \
CONFIG.LAYER6_ENABLE {false} \
CONFIG.LAYER6_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER6_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER6_HEIGHT {720} \
CONFIG.LAYER6_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER6_PRIORITY {1} \
CONFIG.LAYER6_VERTICAL_START_POSITION {0} \
CONFIG.LAYER6_WIDTH {1280} \
CONFIG.LAYER7_ENABLE {false} \
CONFIG.LAYER7_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER7_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER7_HEIGHT {720} \
CONFIG.LAYER7_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER7_PRIORITY {1} \
CONFIG.LAYER7_VERTICAL_START_POSITION {0} \
CONFIG.LAYER7_WIDTH {1280} \
CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
CONFIG.NUMBER_OF_LAYERS {2} \
CONFIG.SCREEN_WIDTH {1920} \
CONFIG.S_AXIS_VIDEO_FORMAT {RGB} \
 ] $v_osd_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_mem_intercon1/S00_AXI] [get_bd_intf_pins axi_vdma_2/M_AXI_MM2S]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_mem_intercon1/S01_AXI] [get_bd_intf_pins axi_vdma_3/M_AXI_S2MM]
  connect_bd_intf_net -intf_net alinx_ov5640_RGB565_0_m_axis_video [get_bd_intf_pins alinx_ov5640_RGB565_0/m_axis_video] [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net alinx_ov5640_RGB565_1_m_axis_video [get_bd_intf_pins alinx_ov5640_RGB565_1/m_axis_video] [get_bd_intf_pins axi_vdma_3/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports hdmi_nreset] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_mem_intercon1_M00_AXI [get_bd_intf_pins axi_mem_intercon1/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_intf_nets axi_vdma_1_M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_2/M_AXIS_MM2S] [get_bd_intf_pins axis_subset_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_osd_0/video_s0_in]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins axis_subset_converter_1/M_AXIS] [get_bd_intf_pins v_osd_0/video_s1_in]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_0 [get_bd_intf_ports HDMI_I2C] [get_bd_intf_pins processing_system7_0/IIC_0]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_dynclk_0/s00_axi] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_2/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_vdma_3/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net Net [get_bd_ports cmos1_sda] [get_bd_pins alinx_ov5640_RGB565_0/cmos_sda]
  connect_bd_net -net Net1 [get_bd_ports cmos1_scl] [get_bd_pins alinx_ov5640_RGB565_0/cmos_scl]
  connect_bd_net -net Net2 [get_bd_ports cmos2_sda] [get_bd_pins alinx_ov5640_RGB565_1/cmos_sda]
  connect_bd_net -net Net3 [get_bd_ports cmos2_scl] [get_bd_pins alinx_ov5640_RGB565_1/cmos_scl]
  connect_bd_net -net alinx_ov5640_RGB565_0_cmos_reset [get_bd_ports cmos1_reset] [get_bd_pins alinx_ov5640_RGB565_0/cmos_reset]
  connect_bd_net -net alinx_ov5640_RGB565_1_cmos_reset [get_bd_ports cmos2_reset] [get_bd_pins alinx_ov5640_RGB565_1/cmos_reset]
  connect_bd_net -net axi_dynclk_0_PXL_CLK_O [get_bd_ports hdmi_clk] [get_bd_pins axi_dynclk_0/PXL_CLK_O] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins axi_vdma_0/mm2s_introut] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net cmos1_href_1 [get_bd_ports cmos1_href] [get_bd_pins alinx_ov5640_RGB565_0/cmos_href]
  connect_bd_net -net cmos1_vsync_1 [get_bd_ports cmos1_vsync] [get_bd_pins alinx_ov5640_RGB565_0/cmos_vsync]
  connect_bd_net -net cmos_d_1 [get_bd_ports cmos2_d] [get_bd_pins alinx_ov5640_RGB565_1/cmos_d]
  connect_bd_net -net cmos_d_2 [get_bd_ports cmos1_d] [get_bd_pins alinx_ov5640_RGB565_0/cmos_d]
  connect_bd_net -net cmos_href_1 [get_bd_ports cmos2_href] [get_bd_pins alinx_ov5640_RGB565_1/cmos_href]
  connect_bd_net -net cmos_pclk_1 [get_bd_ports cmos2_pclk] [get_bd_pins alinx_ov5640_RGB565_1/cmos_pclk]
  connect_bd_net -net cmos_pclk_2 [get_bd_ports cmos1_pclk] [get_bd_pins alinx_ov5640_RGB565_0/cmos_pclk]
  connect_bd_net -net cmos_vsync_1 [get_bd_ports cmos2_vsync] [get_bd_pins alinx_ov5640_RGB565_1/cmos_vsync]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_dynclk_0/REF_CLK_I] [get_bd_pins axi_dynclk_0/s00_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins axi_vdma_2/s_axi_lite_aclk] [get_bd_pins axi_vdma_3/s_axi_lite_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins alinx_ov5640_RGB565_0/aclk] [get_bd_pins alinx_ov5640_RGB565_1/aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon1/ACLK] [get_bd_pins axi_mem_intercon1/M00_ACLK] [get_bd_pins axi_mem_intercon1/S00_ACLK] [get_bd_pins axi_mem_intercon1/S01_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_2/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_2/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_3/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_3/s_axis_s2mm_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins axis_subset_converter_1/aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP1_ACLK] [get_bd_pins rst_processing_system7_0_150M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_osd_0/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins alinx_ov5640_RGB565_0/cmos_xclk] [get_bd_pins alinx_ov5640_RGB565_1/cmos_xclk] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in] [get_bd_pins rst_processing_system7_0_150M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_dynclk_0/s00_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins axi_vdma_2/axi_resetn] [get_bd_pins axi_vdma_3/axi_resetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_140M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins axi_mem_intercon1/ARESETN] [get_bd_pins rst_processing_system7_0_150M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_140M_peripheral_aresetn [get_bd_pins alinx_ov5640_RGB565_0/aresetn] [get_bd_pins alinx_ov5640_RGB565_1/aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon1/M00_ARESETN] [get_bd_pins axi_mem_intercon1/S00_ARESETN] [get_bd_pins axi_mem_intercon1/S01_ARESETN] [get_bd_pins rst_processing_system7_0_150M/peripheral_aresetn]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video [get_bd_ports hdmi_de] [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_ports hdmi_d] [get_bd_pins v_axi4s_vid_out_0/vid_data]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_ports hdmi_hs] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_ports hdmi_vs] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_tc_0_irq [get_bd_pins v_tc_0/irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins alinx_ov5640_RGB565_0/aclken] [get_bd_pins alinx_ov5640_RGB565_0/axis_enable] [get_bd_pins alinx_ov5640_RGB565_1/aclken] [get_bd_pins alinx_ov5640_RGB565_1/axis_enable] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins axis_subset_converter_1/aresetn] [get_bd_pins xlconstant_2/dout]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_2/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_processing_system7_0_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_3/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_processing_system7_0_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dynclk_0/s00_axi/reg0] SEG_axi_dynclk_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43020000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_2/S_AXI_LITE/Reg] SEG_axi_vdma_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43030000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_3/S_AXI_LITE/Reg] SEG_axi_vdma_3_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 1120 -defaultsOSRD
preplace port hdmi_de -pg 1 -y 840 -defaultsOSRD
preplace port cmos2_vsync -pg 1 -y 320 -defaultsOSRD
preplace port cmos2_sda -pg 1 -y 390 -defaultsOSRD
preplace port hdmi_nreset -pg 1 -y 580 -defaultsOSRD
preplace port HDMI_I2C -pg 1 -y 1160 -defaultsOSRD
preplace port cmos1_scl -pg 1 -y 110 -defaultsOSRD
preplace port cmos1_sda -pg 1 -y 130 -defaultsOSRD
preplace port cmos1_href -pg 1 -y 80 -defaultsOSRD
preplace port cmos1_vsync -pg 1 -y 60 -defaultsOSRD
preplace port cmos1_reset -pg 1 -y 150 -defaultsOSRD
preplace port cmos2_scl -pg 1 -y 370 -defaultsOSRD
preplace port hdmi_clk -pg 1 -y 690 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 1140 -defaultsOSRD
preplace port hdmi_hs -pg 1 -y 920 -defaultsOSRD
preplace port cmos2_reset -pg 1 -y 410 -defaultsOSRD
preplace port cmos1_pclk -pg 1 -y 100 -defaultsOSRD
preplace port cmos2_pclk -pg 1 -y 360 -defaultsOSRD
preplace port hdmi_vs -pg 1 -y 960 -defaultsOSRD
preplace port cmos2_href -pg 1 -y 340 -defaultsOSRD
preplace portBus hdmi_d -pg 1 -y 860 -defaultsOSRD
preplace portBus cmos1_d -pg 1 -y 120 -defaultsOSRD
preplace portBus cmos2_d -pg 1 -y 380 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 9 -y 940 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 8 -y 970 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 6 -y 900 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 1 -y 1340 -defaultsOSRD
preplace inst axi_vdma_1 -pg 1 -lvl 2 -y 480 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 6 -y 740 -defaultsOSRD
preplace inst axi_vdma_2 -pg 1 -lvl 2 -y 1150 -defaultsOSRD
preplace inst xlconstant_2 -pg 1 -lvl 6 -y 660 -defaultsOSRD
preplace inst axi_vdma_3 -pg 1 -lvl 2 -y 790 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 9 -y 580 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 3 -y 1440 -defaultsOSRD
preplace inst v_osd_0 -pg 1 -lvl 8 -y 750 -defaultsOSRD
preplace inst axis_subset_converter_0 -pg 1 -lvl 7 -y 760 -defaultsOSRD
preplace inst axi_dynclk_0 -pg 1 -lvl 9 -y 710 -defaultsOSRD
preplace inst alinx_ov5640_RGB565_0 -pg 1 -lvl 9 -y 120 -defaultsOSRD
preplace inst axis_subset_converter_1 -pg 1 -lvl 7 -y 640 -defaultsOSRD
preplace inst alinx_ov5640_RGB565_1 -pg 1 -lvl 9 -y 380 -defaultsOSRD
preplace inst axi_mem_intercon1 -pg 1 -lvl 3 -y 900 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 3 -y 530 -defaultsOSRD
preplace inst rst_processing_system7_0_150M -pg 1 -lvl 2 -y 960 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 5 -y 810 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 4 -y 1190 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 4 6 NJ 1120 NJ 1120 NJ 1120 NJ 1120 NJ 1120 NJ
preplace netloc axis_subset_converter_1_M_AXIS 1 7 1 2540
preplace netloc v_axi4s_vid_out_0_vid_data 1 9 1 NJ
preplace netloc cmos_d_2 1 0 9 NJ 120 NJ 120 NJ 120 NJ 120 NJ 120 NJ 120 NJ 120 NJ 120 NJ
preplace netloc xlconstant_1_dout 1 6 3 2230 460 NJ 460 2850
preplace netloc rst_processing_system7_0_140M_peripheral_aresetn 1 2 7 620 710 NJ 440 NJ 440 NJ 440 NJ 440 NJ 440 2870
preplace netloc axis_subset_converter_0_M_AXIS 1 7 1 2530
preplace netloc axi_vdma_1_M_AXI_S2MM 1 2 1 N
preplace netloc cmos_vsync_1 1 0 9 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ
preplace netloc cmos_pclk_1 1 0 9 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ
preplace netloc xlconstant_2_dout 1 6 1 NJ
preplace netloc axi_dynclk_0_PXL_CLK_O 1 7 3 2570 1100 2860 1080 3190
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 5 4 1830 580 NJ 560 NJ 560 NJ
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 5 1 1850
preplace netloc v_axi4s_vid_out_0_vid_hsync 1 9 1 NJ
preplace netloc cmos_pclk_2 1 0 9 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 4 1 1480
preplace netloc axi_vdma_0_M_AXI_MM2S 1 2 5 650 680 NJ 550 NJ 550 NJ 550 2200
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 1 5 280 1310 NJ 1310 NJ 1310 NJ 1310 1840
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 6 1 2240
preplace netloc cmos_href_1 1 0 9 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ
preplace netloc rst_processing_system7_0_140M_interconnect_aresetn 1 2 1 600
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 5 -100 1430 250 1350 NJ 1350 NJ 1350 1480
preplace netloc v_tc_0_irq 1 2 7 620 1360 NJ 1360 NJ 1360 NJ 1360 NJ 1360 NJ 1360 2830
preplace netloc processing_system7_0_IIC_0 1 4 6 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 NJ
preplace netloc v_osd_0_video_out 1 8 1 2820
preplace netloc axi_mem_intercon_M00_AXI 1 3 1 1060
preplace netloc v_axi4s_vid_out_0_vid_active_video 1 9 1 NJ
preplace netloc alinx_ov5640_RGB565_1_m_axis_video 1 1 9 250 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 3190
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 5 4 NJ 570 NJ 570 NJ 570 2850
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 1 8 220 1250 NJ 1080 NJ 1020 1520 1070 1880 1020 NJ 1020 2560 660 2870
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 1 5 280 1060 NJ 1060 NJ 1040 NJ 1060 1820
preplace netloc xlconcat_0_dout 1 3 1 1050
preplace netloc v_axi4s_vid_out_0_vtg_ce 1 7 3 2580 1110 NJ 1110 3170
preplace netloc processing_system7_0_FIXED_IO 1 4 6 NJ 1140 NJ 1140 NJ 1140 NJ 1140 NJ 1140 NJ
preplace netloc S00_AXI_1 1 2 1 650
preplace netloc axi_vdma_2_M_AXIS_MM2S 1 2 5 NJ 720 NJ 560 NJ 560 NJ 560 2210
preplace netloc axi_vdma_0_mm2s_introut 1 2 5 650 1370 NJ 1370 NJ 1370 NJ 1370 2200
preplace netloc axi_gpio_0_GPIO 1 9 1 NJ
preplace netloc S01_AXI_1 1 2 1 630
preplace netloc alinx_ov5640_RGB565_0_cmos_reset 1 9 1 NJ
preplace netloc cmos1_vsync_1 1 0 9 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ
preplace netloc alinx_ov5640_RGB565_1_cmos_reset 1 9 1 NJ
preplace netloc Net1 1 9 1 NJ
preplace netloc Net 1 9 1 NJ
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 1 4 NJ 690 NJ 690 NJ 670 N
preplace netloc processing_system7_0_FCLK_CLK0 1 0 9 -100 1240 240 1240 NJ 1240 1010 1320 1510 1080 1870 810 NJ 830 2550 650 2860
preplace netloc alinx_ov5640_RGB565_0_m_axis_video 1 1 9 280 380 NJ 380 NJ 380 NJ 380 NJ 380 NJ 380 NJ 380 NJ 510 3200
preplace netloc v_tc_0_vtiming_out 1 8 1 2870
preplace netloc v_axi4s_vid_out_0_vid_vsync 1 9 1 NJ
preplace netloc cmos1_href_1 1 0 9 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 NJ
preplace netloc Net2 1 9 1 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 1 8 260 580 610 1070 1040 1070 1470 1090 1860 800 2270 840 2570 840 2840
preplace netloc axi_mem_intercon1_M00_AXI 1 3 1 1020
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 1 5 270 1050 NJ 1050 NJ 1050 NJ 1050 1830
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 5 3 NJ 790 NJ 890 N
preplace netloc processing_system7_0_FCLK_CLK2 1 4 5 NJ 300 NJ 300 NJ 300 NJ 300 2820
preplace netloc cmos_d_1 1 0 9 NJ 380 NJ 650 NJ 700 NJ 390 NJ 390 NJ 390 NJ 390 NJ 390 NJ
preplace netloc Net3 1 9 1 NJ
levelinfo -pg 1 -120 60 440 870 1280 1680 2040 2400 2700 3020 3220 -top 0 -bot 1500
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


