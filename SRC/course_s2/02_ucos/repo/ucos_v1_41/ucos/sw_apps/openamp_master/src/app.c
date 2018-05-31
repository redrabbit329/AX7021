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
*   This demonstration project illustrate a basic uC/OS-III OpenAMP master project.
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
*       When debugging core 0 and 1 should be loaded at the same time.
*
*   Troubleshooting :
*       By default the Xilinx SDK may not have selected the Micrium drivers for the timer and UART.
*       If that is the case they must be manually selected in the drivers configuration section.
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
#include  <ucos_bsp.h>
#include  <ucos_int.h>

#include  <lib_mem.h>
#include  <lib_str.h>
#include  <include/open_amp.h>
#include  <include/openamp_micrium_core.h>
#include  <cpu_cache.h>
#include  <xparameters.h>
#include  <platform.h>

/*
*********************************************************************************************************
*                                                DEFINES
*********************************************************************************************************
*/

#define  APP_RPMSG_BUF_SIZE       128u


/*
*********************************************************************************************************
*                                       LOCAL GLOBAL VARIABLES
*********************************************************************************************************
*/
                                                                /* OpenAMP Tx/Rx Buffers.                               */
         CPU_INT08U              AppTxBuffer[APP_RPMSG_BUF_SIZE];
         CPU_INT08U              AppRxBuffer[APP_RPMSG_BUF_SIZE];
         struct  rpmsg_channel  *RPMsgChannel;

         OS_SEM                  SlaveInitSem;                  /* Slave Initialized semaphore.                         */
         OS_SEM                  RPMsInitSem;                   /* RPMs Initialized semaphore.                          */
         OS_SEM                  RPMsRxSem;                     /* Message received semaphore.                          */


/*
*********************************************************************************************************
*                                      LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/

void          MainTask             (void *p_arg);

void          SlaveInitISR         (void *p_arg, CPU_INT32U cpu_id);

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
    OS_ERR                os_err;
    struct  remote_proc  *proc;
    CPU_INT32U            ret;
    CPU_CHAR             *msg_payload;
    CPU_INT32U            msg_len;
    CPU_INT32U            rx_msg_len;
    CPU_INT32U            iteration = 0;
    CPU_BOOLEAN           debugging = DEF_FALSE;
    CPU_INT32U            timeout;
    CPU_SR_ALLOC();


    OSSemCreate(&SlaveInitSem, "Slave Initialized semaphore", 0, &os_err);
    OSSemCreate(&RPMsInitSem, "RPMs Initialized semaphore", 0, &os_err);
    OSSemCreate(&RPMsRxSem, "RPMs message received", 0, &os_err);

    UCOS_Print("Starting Core 1.\r\n");

    /* If core 1 is already started this code assumes we are in a debug session. */
    /* In that case core 1 should not be reset.                                  */
    if ((A9_CPU_SLCR_RESET_CTRL & (A9_CPU_SLCR_CLK_STOP | A9_CPU_SLCR_RST)) != 0) {
        CPU_CRITICAL_ENTER();
        _boot_cpu(1);
        CPU_CRITICAL_EXIT();
    } else {
        debugging = DEF_TRUE;
    }

    /* Temporarily setup an interrupt that will be signaled by the slave. */
    /* Once signaled we know the slave has completed init, the kernel is  */
    /* multitasking and OpenAMP remote is ready to receive interrupts.    */
    UCOS_IntVectSet(13, 0, (1 << XPAR_CPU_ID), SlaveInitISR, DEF_NULL);


    if (os_err == OS_ERR_TIMEOUT) {
        UCOS_Print("Error initializing slave core.\r\n");
    }


    UCOS_Print("Initializing remoteproc master targeting remote \"ps7_cortexa9_1\".\r\n");
                                                                /* Initialize Remoteproc.                               */
    ret = remoteproc_init((void *)"ps7_cortexa9_1",
                                  RPMsgChanCreated,
                                  RMPMsgChanDeleted,
                                  RMPMsRx,
                                 &proc);

    /* If debugging, never timeout in case the slave is in debug halt.    */
    /* In a normal boot a timeout would mean the slave never reached      */
    /* an operational state.                                              */
    if (debugging == DEF_TRUE) {
        timeout = 0;
    } else {
        timeout = 1000;
    }

                                                                /* Wait for the slave to be ready.                      */
    OSSemPend(&SlaveInitSem, timeout, OS_OPT_PEND_BLOCKING, DEF_NULL, &os_err);

                                                                /* Start master operations.                             */
    if ((ret == 0) && (proc != DEF_NULL)) {
        ret = remoteproc_boot(proc);
    } else {
        UCOS_Print("Error initializing RemoteProc master.\r\n");
    }

    if (ret == 0) {
        OSSemPend(&RPMsInitSem, 0u, OS_OPT_PEND_BLOCKING, DEF_NULL, &os_err);
    } else {
        UCOS_Print("Error starting RemoteProc master.\r\n");
    }

    if (RPMsgChannel != DEF_NULL) {
        UCOS_Printf("Remote device initialized. Channel %s created.\r\n", RPMsgChannel->name);

        OSTimeDlyHMSM(0, 0, 2, 0, OS_OPT_TIME_HMSM_STRICT, &os_err);

        msg_payload = "Test payload\r\n";
        msg_len = Str_Len(msg_payload);

                                                                /* Send test messages and wait for reply in a loop.     */
        while (DEF_TRUE) {
            UCOS_Printf("Sending test message iteration %d.\r\n", iteration);
            Str_Copy_N((CPU_CHAR *)AppTxBuffer, msg_payload, msg_len);
            rpmsg_send(RPMsgChannel, AppTxBuffer, msg_len);

            OSSemPend(&RPMsRxSem, 0u, OS_OPT_PEND_BLOCKING, DEF_NULL, &os_err);
            UCOS_Printf("Reply received!\r\n");
            UCOS_Printf("Sent message: %s", msg_payload);

            rx_msg_len = Str_Len_N((CPU_CHAR *)AppRxBuffer, sizeof(AppRxBuffer));/* Verify string length.               */

            if (rx_msg_len == msg_len) {
                UCOS_Printf("Received message: %s", (CPU_CHAR *)AppRxBuffer);
            } else {
                UCOS_Print("Corrupted message received.\r\n");
                break;
            }
            UCOS_Print("\r\n");


            OSTimeDlyHMSM(0, 0, 5, 0, OS_OPT_TIME_HMSM_STRICT, &os_err);
            iteration++;
        }
    }

    while (DEF_TRUE) {
        OSTimeDlyHMSM(0, 0, 1, 0, OS_OPT_TIME_HMSM_STRICT, &os_err);
    }

}


void  RPMsgChanCreated (struct  rpmsg_channel  *rp_chnl)
{
    OS_ERR os_err;


    RPMsgChannel = rp_chnl;                                     /* Channel created notify application.                   */
    OSSemPost(&RPMsInitSem, OS_OPT_POST_1, &os_err);
}

void  RMPMsgChanDeleted (struct rpmsg_channel *rp_chnl)
{
    /* Handle channel deletion. */
}

void  RMPMsRx(struct  rpmsg_channel  *rp_chnl,
                  void                   *data,
                  int                     len,
                  void                   *priv,
                  unsigned  long          src)
{
    OS_ERR  os_err;

                                                                /* Copy message.                                        */
    Mem_Copy((void *)&AppRxBuffer, data, len);

                                                                /* Notify main task.                                    */
    OSSemPost(&RPMsRxSem, OS_OPT_POST_1, &os_err);
}


void  SlaveInitISR (void *p_arg, CPU_INT32U cpu_id)
{
    OS_ERR  os_err;


    OSSemPost(&SlaveInitSem, OS_OPT_POST_1, &os_err);
}
