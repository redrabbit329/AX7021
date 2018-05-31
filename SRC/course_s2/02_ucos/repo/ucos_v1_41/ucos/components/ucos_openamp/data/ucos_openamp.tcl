#########################################################################################################
#                                           MICRIUM XSDK REPOSITORY
#                           (c) Copyright 2014-2015; Micrium, Inc.; Weston, FL
#
#               All rights reserved.  Protected by international copyright laws.
#########################################################################################################

source ../../../bsp/data/ucos_tcl_utils.tcl
source ../../../bsp/data/xil_tcl_utils.tcl

proc generate {ucos_handle} {
    ucos_log_put "TRACE" "Generating ucos_open-amp."
    
    set ucos_src_base [ucos_get_source_base]
    set openamp_src_base [ucos_get_product_source_base openamp]
    
    if {[llength $openamp_src_base] == 0} {
        set openamp_src_base $ucos_src_base
    }
    
    file copy -force "$openamp_src_base/openamp" "./src/openamp"
    file delete -force "./src/openamp/porting/config/config.c"
    file delete -force "./src/openamp/porting/config/config.h"
    
    file mkdir "../../include/include/"
    file mkdir "../../include/source/"
    
    set sw_proc_handle [get_sw_processor]
    set hw_proc_handle [get_cells [get_property HW_INSTANCE $sw_proc_handle] ]

    set proctype [get_property IP_NAME $hw_proc_handle]
    
    switch $proctype {
    "microblaze" { 
        file copy -force "./src/mb/Makefile.inc" "./src/Makefile.inc"
    }
    
    "ps7_cortexa9" {
        file copy -force "./src/ps7/Makefile.inc" "./src/Makefile.inc"
    }

    "default" {error "Unknown processor type"}
    }
    
    
    set config_file [open_include_file "xparameters.h"]
    
    set prio [get_property CONFIG.OPENAMP_OS_CFG_TASK_PRIO $ucos_handle]
    set stack [get_property CONFIG.OPENAMP_OS_CFG_TASK_STK_SIZE $ucos_handle]
    
    puts $config_file "#define OPENAMP_OS_CFG_TASK_PRIO $prio"
    puts $config_file "#define OPENAMP_OS_CFG_TASK_STK_SIZE $stack"
    
    
    set master_id [get_property CONFIG.OPENAMP_CFG_MASTER_ID $ucos_handle]
    
    puts $config_file "#define OPENAMP_CFG_MASTER_ID $master_id"
    
    
    set core_en [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_ID $cpu_id"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_SIZE $shmem_size"
    } else {
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_0_EN DEF_DISABLED"
    }
    
    set core_en [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_ID $cpu_id"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_SIZE $shmem_size"
    } else {
        puts $config_file "#define OPENAMP_ZYNQ_AMP_CORE_1_EN DEF_DISABLED"
    }

    
    set core_en [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_ID $cpu_id"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_SIZE $shmem_size"  
    } else {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_0_EN DEF_DISABLED"
    }
    
    
    set core_en [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_ID $cpu_id"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_SIZE $shmem_size"  
    } else {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_1_EN DEF_DISABLED"
    }
    
    
    set core_en [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_ID $cpu_id"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_SIZE $shmem_size"  
    } else {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_2_EN DEF_DISABLED"
    }
    
    
    set core_en [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_EN $ucos_handle]
    set cpu_id [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_ID $ucos_handle]
    set tx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_TX_VRING_ADDR $ucos_handle]
    set rx_vring [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_RX_VRING_ADDR $ucos_handle]
    set vring_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_SIZE $ucos_handle]
    set vring_align [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_ALIGN $ucos_handle]
    set tx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_TX_INTR $ucos_handle]
    set rx_isr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_RX_INTR $ucos_handle]
    set shmem_addr [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_ADDR $ucos_handle]
    set shmem_size [get_property CONFIG.OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_SIZE $ucos_handle]
    
    if {$core_en == "true"} {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_EN DEF_ENABLED"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_ID $cpu_id"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_TX_VRING_ADDR $tx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_RX_VRING_ADDR $rx_vring"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_SIZE $vring_size"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_ALIGN $vring_align"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_TX_INTR $tx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_RX_INTR $rx_isr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_ADDR $shmem_addr"
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_SIZE $shmem_size"  
    } else {
        puts $config_file "#define OPENAMP_MICROBLAZE_AMP_CORE_3_EN DEF_DISABLED"
    }
}
