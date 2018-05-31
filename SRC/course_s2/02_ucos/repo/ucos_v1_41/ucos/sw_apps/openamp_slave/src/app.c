/*
*********************************************************************************************************
*                                            EXAMPLE CODE
*
*                          (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*
*               Please feel free to use any application code labeled as 'EXAMPLE CODE' in
*               your application products.  Example code may be used as is, in whole or in
*               part, or may be used as a reference only.
*
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*
*               You can contact us at www.micrium.com.
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                          SETUP INSTRUCTIONS
*
*   This demonstration project illustrate a basic uC/OS-III OpenAMP slave project.
*
*   By default some configuration steps are required to compile this example :
*
*   1. Include the require Micrium software components
*       In the BSP setting dialog in the "overview" section of the left pane the following libraries
*       should be added to the BSP :
*
*           ucos_common
*           ucos_osiii
*           ucos_standalone
*           ucos_openamp
*
*   2. Kernel tick source - (Not required on the Zynq-7000 PS)
*       If a suitable timer is available in your FPGA design it can be used as the kernel tick source.
*       To do so, in the "ucos" section select a timer for the "kernel_tick_src" configuration option.
*
*   3. STDOUT configuration
*       Output from the print() and UCOS_Print() functions can be redirected to a supported UART. In
*       the "ucos" section the stdout configuration will list the available UARTs.
*
*   4. Debug procedure
*       This slave project should be loaded at the same time as the master project.
*
*   Troubleshooting :
*       By default the Xilinx SDK may not have selected the Micrium drivers for the timer and UART.
*       If that is the case they must be manually selected in the drivers configuration section.
*
*       Finally make sure the FPGA is programmed before debugging.
*
*
*   Remember that this example is provided for evaluation purposes only. Commercial development requires
*   a valid license from Micrium.
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  <stdio.h>
#include  <Source/os.h>
#include  <app_cfg.h>
#include  <cpu.h>
#include  <ucos_bsp.h>
#include  <ucos_scugic.h>

#include  <ucos_cpu_cortexa9.h>
#include  <ucos_int.h>
#include  <ucos_osiii_bsp.h>
#include  <xparameters.h>
#include  <KAL/kal.h>

#include  <include/open_amp.h>
#include  <include/openamp_micrium_core.h>
#include  "rsc_table.h"


/*
*********************************************************************************************************
*                                                DEFINES
*********************************************************************************************************
*/

#define  APP_RPMSG_BUF_SIZE                       128u


/*
*********************************************************************************************************
*                                       LOCAL GLOBAL VARIABLES
*********************************************************************************************************
*/

    CPU_DATA        RPMsgInit;
    CPU_INT08U      AppTxBuffer[APP_RPMSG_BUF_SIZE];

    OS_SEM          RPMsInitSem;                   /* RPMs Initialized semaphore.                          */

extern  const  struct remote_resource_table  ps7_core1_resources;


/*
*********************************************************************************************************
*                                      LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/


void  MainTask (void *p_arg);

static  void  RPMsgChanCreated     (struct  rpmsg_channel  *p_chnl);

static  void  RMPMsgChanDeleted    (struct  rpmsg_channel  *p_chnl);

static  void  RMPMsRx              (struct  rpmsg_channel  *p_chnl,
                                    void                   *data,
                                    int                     len,
                                    void                   *priv,
                                    unsigned  long          src);


/*
*********************************************************************************************************
*                                               main()
*
* Description : Entry point for C code.
*
*********************************************************************************************************
*/

int main()
{

    UCOSStartup(MainTask);

    return 0;
}

/*
*********************************************************************************************************
*                                             MainTask()
*
* Description : Startup task example code.
*
* Returns     : none.
*
* Created by  : main().
*********************************************************************************************************
*/

void  MainTask (void *p_arg)
{
    OS_ERR                   os_err;
    struct  remote_proc     *proc = NULL;
    struct  rsc_table_info   rsc_info;
    int                      ret;


    OSSemCreate(&RPMsInitSem, "RPMs Initialized semaphore", 0, &os_err);

                                                                /* Initialize Remoteproc.                               */
    RPMsgInit      = 0u;
    rsc_info.rsc_tab = (struct resource_table *)&ps7_core1_resources;
    rsc_info.size    =  sizeof(ps7_core1_resources);

    ret = remoteproc_resource_init(&rsc_info,
                                    RPMsgChanCreated,
                                    RMPMsgChanDeleted,
                                    RMPMsRx,
                                   &proc);

                                                                /* Signal the master that we are ready.                 */
    SCUGIC_SGITrig(13, DEF_BIT_00);

    if (ret == 0) {
        OSSemPend(&RPMsInitSem, 0u, OS_OPT_PEND_BLOCKING, DEF_NULL, &os_err);
    }

    while (DEF_TRUE) {
        OSTimeDlyHMSM(0, 0, 0, 500, OS_OPT_TIME_HMSM_STRICT, &os_err);
    }

}


void  RPMsgChanCreated (struct  rpmsg_channel  *rp_chnl)
{
    OS_ERR os_err;


    RPMsgInit = 1u;
    OSSemPost(&RPMsInitSem, OS_OPT_POST_1, &os_err);
}

void  RMPMsgChanDeleted (struct rpmsg_channel *rp_chnl) {
    /* Handle channel deletion. */
}

void  RMPMsRx(struct  rpmsg_channel  *rp_chnl,
              void                   *data,
              int                     len,
              void                   *priv,
              unsigned  long          src)
{

    rpmsg_send(rp_chnl, data, len);                             /* Send back the received data.                         */
}

