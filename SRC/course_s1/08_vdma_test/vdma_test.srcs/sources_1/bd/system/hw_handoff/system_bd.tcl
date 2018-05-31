
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
  set hdmi_clk [ create_bd_port -dir O -type clk hdmi_clk ]
  set hdmi_d [ create_bd_port -dir O -from 23 -to 0 hdmi_d ]
  set hdmi_de [ create_bd_port -dir O hdmi_de ]
  set hdmi_hs [ create_bd_port -dir O hdmi_hs ]
  set hdmi_vs [ create_bd_port -dir O hdmi_vs ]

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
CONFIG.NUM_SI {1} \
 ] $axi_mem_intercon

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {256} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
 ] $axi_vdma_0

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

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {767} \
CONFIG.PCW_ENET0_ENET0_IO {<Select>} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {0} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {<Select>} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_IO {<Select>} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0} \
CONFIG.PCW_GPIO_MIO_GPIO_IO {<Select>} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_16_IOTYPE {<Select>} \
CONFIG.PCW_MIO_16_SLEW {<Select>} \
CONFIG.PCW_MIO_17_IOTYPE {<Select>} \
CONFIG.PCW_MIO_17_SLEW {<Select>} \
CONFIG.PCW_MIO_18_IOTYPE {<Select>} \
CONFIG.PCW_MIO_18_SLEW {<Select>} \
CONFIG.PCW_MIO_19_IOTYPE {<Select>} \
CONFIG.PCW_MIO_19_SLEW {<Select>} \
CONFIG.PCW_MIO_1_SLEW {<Select>} \
CONFIG.PCW_MIO_20_IOTYPE {<Select>} \
CONFIG.PCW_MIO_20_SLEW {<Select>} \
CONFIG.PCW_MIO_21_IOTYPE {<Select>} \
CONFIG.PCW_MIO_21_SLEW {<Select>} \
CONFIG.PCW_MIO_22_IOTYPE {<Select>} \
CONFIG.PCW_MIO_22_SLEW {<Select>} \
CONFIG.PCW_MIO_23_IOTYPE {<Select>} \
CONFIG.PCW_MIO_23_SLEW {<Select>} \
CONFIG.PCW_MIO_24_IOTYPE {<Select>} \
CONFIG.PCW_MIO_24_SLEW {<Select>} \
CONFIG.PCW_MIO_25_IOTYPE {<Select>} \
CONFIG.PCW_MIO_25_SLEW {<Select>} \
CONFIG.PCW_MIO_26_IOTYPE {<Select>} \
CONFIG.PCW_MIO_26_SLEW {<Select>} \
CONFIG.PCW_MIO_27_IOTYPE {<Select>} \
CONFIG.PCW_MIO_27_SLEW {<Select>} \
CONFIG.PCW_MIO_28_SLEW {<Select>} \
CONFIG.PCW_MIO_29_SLEW {<Select>} \
CONFIG.PCW_MIO_2_SLEW {<Select>} \
CONFIG.PCW_MIO_30_SLEW {<Select>} \
CONFIG.PCW_MIO_31_SLEW {<Select>} \
CONFIG.PCW_MIO_32_SLEW {<Select>} \
CONFIG.PCW_MIO_33_SLEW {<Select>} \
CONFIG.PCW_MIO_34_SLEW {<Select>} \
CONFIG.PCW_MIO_35_SLEW {<Select>} \
CONFIG.PCW_MIO_36_SLEW {<Select>} \
CONFIG.PCW_MIO_37_SLEW {<Select>} \
CONFIG.PCW_MIO_38_SLEW {<Select>} \
CONFIG.PCW_MIO_39_SLEW {<Select>} \
CONFIG.PCW_MIO_3_SLEW {<Select>} \
CONFIG.PCW_MIO_40_SLEW {<Select>} \
CONFIG.PCW_MIO_41_SLEW {<Select>} \
CONFIG.PCW_MIO_42_SLEW {<Select>} \
CONFIG.PCW_MIO_43_SLEW {<Select>} \
CONFIG.PCW_MIO_44_SLEW {<Select>} \
CONFIG.PCW_MIO_45_SLEW {<Select>} \
CONFIG.PCW_MIO_46_SLEW {<Select>} \
CONFIG.PCW_MIO_47_SLEW {<Select>} \
CONFIG.PCW_MIO_48_SLEW {<Select>} \
CONFIG.PCW_MIO_49_SLEW {<Select>} \
CONFIG.PCW_MIO_4_SLEW {<Select>} \
CONFIG.PCW_MIO_50_SLEW {<Select>} \
CONFIG.PCW_MIO_51_SLEW {<Select>} \
CONFIG.PCW_MIO_52_SLEW {<Select>} \
CONFIG.PCW_MIO_53_SLEW {<Select>} \
CONFIG.PCW_MIO_5_SLEW {<Select>} \
CONFIG.PCW_MIO_6_SLEW {<Select>} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_QSPI_QSPI_IO {<Select>} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {0} \
CONFIG.PCW_SD0_GRP_CD_IO {<Select>} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD1_SD1_IO {<Select>} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 12 .. 13} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB0_RESET_ENABLE {0} \
CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {6} \
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

  # Create interface connections
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports hdmi_nreset] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_0 [get_bd_intf_ports HDMI_I2C] [get_bd_intf_pins processing_system7_0/IIC_0]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_dynclk_0/s00_axi] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net axi_dynclk_0_PXL_CLK_O [get_bd_ports hdmi_clk] [get_bd_pins axi_dynclk_0/PXL_CLK_O] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins axi_vdma_0/mm2s_introut] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_dynclk_0/REF_CLK_I] [get_bd_pins axi_dynclk_0/s00_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins rst_processing_system7_0_150M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in] [get_bd_pins rst_processing_system7_0_150M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_dynclk_0/s00_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_140M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_150M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_140M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins rst_processing_system7_0_150M/peripheral_aresetn]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video [get_bd_ports hdmi_de] [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_ports hdmi_d] [get_bd_pins v_axi4s_vid_out_0/vid_data]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_ports hdmi_hs] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_ports hdmi_vs] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_tc_0_irq [get_bd_pins v_tc_0/irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dynclk_0/s00_axi/reg0] SEG_axi_dynclk_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 80 -defaultsOSRD
preplace port hdmi_de -pg 1 -y 620 -defaultsOSRD
preplace port hdmi_nreset -pg 1 -y 340 -defaultsOSRD
preplace port HDMI_I2C -pg 1 -y 120 -defaultsOSRD
preplace port hdmi_clk -pg 1 -y 450 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 100 -defaultsOSRD
preplace port hdmi_hs -pg 1 -y 660 -defaultsOSRD
preplace port hdmi_vs -pg 1 -y 680 -defaultsOSRD
preplace portBus hdmi_d -pg 1 -y 640 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 5 -y 690 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 4 -y 680 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 3 -y 300 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 1 -y 260 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 3 -y 500 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 4 -y 320 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 5 -y 340 -defaultsOSRD
preplace inst axis_subset_converter_0 -pg 1 -lvl 4 -y 480 -defaultsOSRD
preplace inst axi_dynclk_0 -pg 1 -lvl 5 -y 470 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 4 -y 130 -defaultsOSRD
preplace inst rst_processing_system7_0_150M -pg 1 -lvl 3 -y 110 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 390 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 5 -y 140 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 5 1 NJ
preplace netloc xlconstant_1_dout 1 3 1 NJ
preplace netloc v_axi4s_vid_out_0_vid_data 1 5 1 NJ
preplace netloc rst_processing_system7_0_140M_peripheral_aresetn 1 3 1 1080
preplace netloc axis_subset_converter_0_M_AXIS 1 4 1 1380
preplace netloc axi_dynclk_0_PXL_CLK_O 1 3 3 1100 810 1430 550 1840
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 2 3 NJ 410 NJ 410 1420
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 1 680
preplace netloc v_axi4s_vid_out_0_vid_hsync 1 5 1 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 1 5 370 170 NJ 200 NJ 250 NJ 250 1830
preplace netloc axi_vdma_0_M_AXI_MM2S 1 3 1 1040
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 3 1 1050
preplace netloc v_tc_0_irq 1 3 2 1080 820 1390
preplace netloc rst_processing_system7_0_140M_interconnect_aresetn 1 3 1 1050
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 6 20 90 NJ 90 690 10 NJ 10 NJ 10 1850
preplace netloc processing_system7_0_IIC_0 1 5 1 NJ
preplace netloc axi_mem_intercon_M00_AXI 1 4 1 1380
preplace netloc v_axi4s_vid_out_0_vid_active_video 1 5 1 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 3 NJ 400 NJ 400 1430
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 1 4 360 140 690 210 1030 380 1440
preplace netloc xlconcat_0_dout 1 4 1 1400
preplace netloc v_axi4s_vid_out_0_vtg_ce 1 3 3 1090 830 NJ 830 1820
preplace netloc processing_system7_0_FIXED_IO 1 5 1 NJ
preplace netloc axi_vdma_0_mm2s_introut 1 3 1 1070
preplace netloc axi_gpio_0_GPIO 1 5 1 NJ
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 1 1 370
preplace netloc processing_system7_0_FCLK_CLK0 1 0 6 30 350 350 160 670 550 1050 550 1390 30 1820
preplace netloc v_tc_0_vtiming_out 1 4 1 1440
preplace netloc v_axi4s_vid_out_0_vid_vsync 1 5 1 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 2 4 700 20 1060 260 1410 20 1840
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 2 690 390 NJ
levelinfo -pg 1 0 190 510 860 1240 1630 1870 -top 0 -bot 840
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


