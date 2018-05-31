/*
************************************************************************************************************************
*                                                      uC/OS-III
*                                                 The Real-Time Kernel
*
*                                  (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*                           All rights reserved.  Protected by international copyright laws.
*
*                                                  CONFIGURATION FILE
*
* File    : OS_CFG.H
* By      : JJL
* Version : V3.05.01
*
* LICENSING TERMS:
* ---------------
*           uC/OS-III is provided in source form for FREE short-term evaluation, for educational use or
*           for peaceful research.  If you plan or intend to use uC/OS-III in a commercial application/
*           product then, you need to contact Micrium to properly license uC/OS-III for its use in your
*           application/product.   We provide ALL the source code for your convenience and to help you
*           experience uC/OS-III.  The fact that the source is provided does NOT mean that you can use
*           it commercially without paying a licensing fee.
*
*           Knowledge of the source code may NOT be used to develop a similar product.
*
*           Please help us continue to provide the embedded community with the finest software available.
*           Your honesty is greatly appreciated.
*
*           You can find our product's user manual, API reference, release notes and
*           more information at https://doc.micrium.com.
*           You can contact us at www.micrium.com.
************************************************************************************************************************
*/

#ifndef OS_CFG_H
#define OS_CFG_H

                                                           /* --------------------------- MISCELLANEOUS --------------------------- */
#define OS_CFG_APP_HOOKS_EN             DEF_ENABLED
#define OS_CFG_ARG_CHK_EN               DEF_ENABLED
#define OS_CFG_CALLED_FROM_ISR_CHK_EN   DEF_ENABLED
#define OS_CFG_DBG_EN                   DEF_ENABLED
#define OS_CFG_DYN_TICK_EN              DEF_DISABLED
#define OS_CFG_INVALID_OS_CALLS_CHK_EN  DEF_DISABLED
#define OS_CFG_ISR_POST_DEFERRED_EN     DEF_DISABLED
#define OS_CFG_OBJ_TYPE_CHK_EN          DEF_ENABLED
#define OS_CFG_TS_EN                    DEF_DISABLED

#define OS_CFG_PEND_MULTI_EN            DEF_DISABLED

#define OS_CFG_PRIO_MAX                 64

#define OS_CFG_SCHED_LOCK_TIME_MEAS_EN  DEF_DISABLED
#define OS_CFG_SCHED_ROUND_ROBIN_EN     DEF_DISABLED

#define OS_CFG_STK_SIZE_MIN             64


                                                           /* --------------------------- EVENT FLAGS ----------------------------- */
#define OS_CFG_FLAG_EN                  DEF_ENABLED
#define OS_CFG_FLAG_DEL_EN              DEF_ENABLED
#define OS_CFG_FLAG_MODE_CLR_EN         DEF_ENABLED
#define OS_CFG_FLAG_PEND_ABORT_EN       DEF_ENABLED


                                                           /* ------------------------ MEMORY MANAGEMENT -------------------------  */
#define OS_CFG_MEM_EN                   DEF_ENABLED


                                                           /* ------------------- MUTUAL EXCLUSION SEMAPHORES --------------------  */
#define OS_CFG_MUTEX_EN                 DEF_ENABLED
#define OS_CFG_MUTEX_DEL_EN             DEF_ENABLED
#define OS_CFG_MUTEX_PEND_ABORT_EN      DEF_ENABLED


                                                           /* -------------------------- MESSAGE QUEUES --------------------------  */
#define OS_CFG_Q_EN                     DEF_ENABLED
#define OS_CFG_Q_DEL_EN                 DEF_ENABLED
#define OS_CFG_Q_FLUSH_EN               DEF_ENABLED
#define OS_CFG_Q_PEND_ABORT_EN          DEF_ENABLED


                                                           /* ---------------------------- SEMAPHORES ----------------------------- */
#define OS_CFG_SEM_EN                   DEF_ENABLED
#define OS_CFG_SEM_DEL_EN               DEF_ENABLED
#define OS_CFG_SEM_PEND_ABORT_EN        DEF_ENABLED
#define OS_CFG_SEM_SET_EN               DEF_ENABLED


                                                           /* ----------------------------- MONITORS ------------------------------ */
#define OS_CFG_MON_EN                   DEF_ENABLED
#define OS_CFG_MON_DEL_EN               DEF_ENABLED

                                                           /* -------------------------- TASK MANAGEMENT -------------------------- */
#define OS_CFG_STAT_TASK_EN             DEF_DISABLED
#define OS_CFG_STAT_TASK_STK_CHK_EN     DEF_DISABLED

#define OS_CFG_TASK_CHANGE_PRIO_EN      DEF_ENABLED
#define OS_CFG_TASK_DEL_EN              DEF_ENABLED
#define OS_CFG_TASK_IDLE_EN             DEF_ENABLED
#define OS_CFG_TASK_PROFILE_EN          DEF_DISABLED
#define OS_CFG_TASK_Q_EN                DEF_ENABLED
#define OS_CFG_TASK_Q_PEND_ABORT_EN     DEF_ENABLED
#define OS_CFG_TASK_REG_TBL_SIZE        2
#define OS_CFG_TASK_STK_REDZONE_EN      DEF_DISABLED
#define OS_CFG_TASK_STK_REDZONE_DEPTH   8
#define OS_CFG_TASK_SEM_PEND_ABORT_EN   DEF_ENABLED
#define OS_CFG_TASK_SUSPEND_EN          DEF_ENABLED
#define OS_CFG_TASK_TICK_EN             DEF_ENABLED        /* Include (DEF_ENABLED) the kernel tick task                            */

                                                           /* ------------------ TASK LOCAL STORAGE MANAGEMENT -------------------  */
#define OS_CFG_TLS_TBL_SIZE             0

                                                           /* ------------------------- TIME MANAGEMENT --------------------------  */
#define OS_CFG_TIME_DLY_HMSM_EN         DEF_ENABLED
#define OS_CFG_TIME_DLY_RESUME_EN       DEF_ENABLED

                                                           /* ------------------------- TIMER MANAGEMENT -------------------------- */
#define OS_CFG_TMR_EN                   DEF_ENABLED
#define OS_CFG_TMR_DEL_EN               DEF_ENABLED

                                                           /* uC/TRACE                                                              */
#define TRACE_CFG_EN                    DEF_DISABLED

#endif
