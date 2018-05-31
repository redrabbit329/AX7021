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
*
*                                       OpenAMP ENVIRONEMENT PORT
*
*                                             ZYNQ 7000 EPP
*                                                on the
*                                        ZC702 development board
*
* Filename      : uCOS-III_env.c
* Version       : V1.00
* Programmer(s) : JFT
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  <source/env.h>
#include  <config.h>
#include  <source/hil.h>
#include  <include/openamp_micrium_core.h>

#include  <xparameters.h>

#include  <lib_def.h>
#include  <lib_mem.h>
#include  <lib_str.h>
#include  <cpu.h>
#include  <cpu_cache.h>

#include  <ucos_int.h>

#include  <kal/kal.h>


/*
*********************************************************************************************************
*                                                 TYPES
*********************************************************************************************************
*/

typedef  void  (*BSP_INT_FNCT_PTR)(CPU_INT32U);
typedef  void  (*PLATFORM_ISR)(void *data);


/*
*********************************************************************************************************
*                                                DEFINES
*********************************************************************************************************
*/

                                                                /* Dynamic memory management.                           */
#define  ENV_MEM_SEG_SIZE                     (8*1024u)
                                                                /* Vring interrupt management.                          */
#define  ENV_ISR_COUNT
#define  ENV_TX_QUEUE_NAME                      "tx_vq"
#define  ENV_RX_QUEUE_NAME                      "rx_vq"
#define  ENV_MASTER_ID                               0u
#define  ENV_MASTER_TARGET_SELF                   0x01u
#define  ENV_MASTER_TARGET_OTHER                  0x02u
#define  ENV_REMOTE_TARGET_SELF                   0x02u
#define  ENV_REMOTE_TARGET_OTHER                  0x01u


/*
*********************************************************************************************************
*                                        LOCAL GLOBAL VARIABLES
*********************************************************************************************************
*/
                                                                /* Dynamic memory management.                           */
static  MEM_SEG              env_MemSeg;
static  CPU_INT08U           env_MemSegBuffer[ENV_MEM_SEG_SIZE];
                                                                /* Core identification.                                 */
        CPU_INT32S           env_WhoAmI;
                                                                /* Vring interrupt management.                          */
        struct  proc_vring  *Tx_vring;
        PLATFORM_ISR         Tx_callback;
        struct  proc_vring  *Rx_vring;
        PLATFORM_ISR         Rx_callback;


/*
*********************************************************************************************************
*                                            LOCAL FUNCTIONS
*********************************************************************************************************
*/

        void           env_tx_isr       (void           *p_arg,
                                         CPU_INT32U      cpu_id);

        void           env_rx_isr       (void           *p_arg,
                                         CPU_INT32U      cpu_id);


/*
*********************************************************************************************************
*                                       'env' API IMPLEMENTATION
*********************************************************************************************************
*/

/**
 * env_init
 *
 * Initializes Environment.
 *
 */
int env_init() {
           LIB_ERR     err_lib   = LIB_ERR_NONE;
    static CPU_DATA    init_done = 0u;


    if (!init_done) {
                                                                /* Get environment's CPU ID.                            */
        env_WhoAmI = XPAR_CPU_ID;

                                                                /* Dynamic memory management.                           */
        Mem_SegCreate("ENV MemSeg",
                      &env_MemSeg,
                      (CPU_ADDR)&env_MemSegBuffer[0],
                      (CPU_SIZE_T)ENV_MEM_SEG_SIZE,
                       LIB_MEM_PADDING_ALIGN_NONE,
                      &err_lib);
        if (err_lib != LIB_MEM_ERR_NONE) {
            return -1;
        }

        init_done = 1;
    }

    return 0;
}

/**
 * env_deinit
 *
 * Uninitializes Environment.
 *
 * @returns - execution status
 */

int env_deinit() {
    return 0;
}
/**
 * env_allocate_memory - implementation
 *
 * @param size
 */
void *env_allocate_memory(unsigned int size)
{
    LIB_ERR  lib_err;
    void    *p_block;


    if (size <= ENV_MEM_SEG_SIZE) {
        p_block = Mem_SegAlloc(DEF_NULL, &env_MemSeg, size, &lib_err);
    } else {
        p_block = NULL;
    }

    return p_block;
}

/**
 * env_free_memory - implementation
 *
 * @param ptr
 */
void env_free_memory(void *ptr)
{

}

/**
 * env_register_isr
 *
 * Registers interrupt handler for the given interrupt vector.
 *
 * @param vector - interrupt vector number
 * @param isr    - interrupt handler
 */
void env_register_isr(int vector , void *data , PLATFORM_ISR isr)
{
    struct  proc_vring  *vring;


    vring = (struct proc_vring *)data;

    if (Str_Cmp(vring->vq->vq_name, ENV_TX_QUEUE_NAME) == 0) {
        Tx_vring    = vring;
        Tx_callback = isr;
    } else if (Str_Cmp(vring->vq->vq_name, ENV_RX_QUEUE_NAME) == 0) {
        Rx_vring    = vring;
        Rx_callback = isr;
    }
}

/**
 * env_enable_interrupt
 *
 * Enables the given interrupt
 *
 * @param vector   - interrupt vector number
 * @param priority - interrupt priority
 * @param polarity - interrupt polarity
 */

void env_enable_interrupt(void *data)
{
    CPU_INT08U  target;
    struct  proc_vring  *vring;
    CPU_SR_ALLOC();


    vring = (struct proc_vring *)data;

    CPU_CRITICAL_ENTER();

    CPU_MB();
    if (Str_Cmp(vring->vq->vq_name, ENV_TX_QUEUE_NAME) == 0) {
        target = env_WhoAmI == ENV_MASTER_ID ? ENV_MASTER_TARGET_SELF : ENV_REMOTE_TARGET_SELF;
        UCOS_IntVectSet(vring->intr_info.vect_id,
                        vring->intr_info.priority,
                        target,
                        env_tx_isr,
                        DEF_NULL);
    } else if (Str_Cmp(vring->vq->vq_name, ENV_RX_QUEUE_NAME) == 0) {
        target = env_WhoAmI == ENV_MASTER_ID ? ENV_MASTER_TARGET_OTHER : ENV_REMOTE_TARGET_OTHER;
        UCOS_IntVectSet(vring->intr_info.vect_id,
                        vring->intr_info.priority,
                        target,
                        env_rx_isr,
                        DEF_NULL);
    }

    UCOS_IntSrcEn(vring->intr_info.vect_id);

    CPU_CRITICAL_EXIT();
}

void  env_tx_isr(void  *p_arg, CPU_INT32U  cpu_id)
{
    CPU_MB();

    OpenAMP_TaskQPost((void *)Tx_vring);
}


void  env_rx_isr(void  *p_arg, CPU_INT32U  cpu_id)
{
    CPU_MB();

    OpenAMP_TaskQPost((void *)Rx_vring);
}

