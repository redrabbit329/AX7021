/*
************************************************************************************************************************
*                                                      uC/OS-III
*                                                 The Real-Time Kernel
*
*                                  (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*                           All rights reserved.  Protected by international copyright laws.
*
*                                       OS CONFIGURATION (APPLICATION SPECIFICS)
*
* File    : OS_CFG_APP.H
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

#ifndef OS_CFG_APP_H
#define OS_CFG_APP_H

/*
************************************************************************************************************************
*                                                      CONSTANTS
************************************************************************************************************************
*/
                                                                /* ------------------ MISCELLANEOUS ------------------- */
#define  OS_CFG_ISR_STK_SIZE                         512

#define  OS_CFG_MSG_POOL_SIZE                         48

#define  OS_CFG_TASK_STK_LIMIT_PCT_EMPTY              10u       /* Stack limit position in percentage to empty          */


                                                                /* -------------------- IDLE TASK --------------------- */
#define  OS_CFG_IDLE_TASK_STK_SIZE                    256


                                                                /* ----------------- ISR HANDLER TASK ----------------- */
#define  OS_CFG_INT_Q_SIZE                            10u       /* Size of ISR handler task queue                       */
#define  OS_CFG_INT_Q_TASK_STK_SIZE                  100u       /* Stack size (number of CPU_STK elements)              */


                                                                /* ------------------ STATISTIC TASK ------------------ */
#define  OS_CFG_STAT_TASK_PRIO       10
#define  OS_CFG_STAT_TASK_RATE_HZ                     10
#define  OS_CFG_STAT_TASK_STK_SIZE                   256


                                                                /* ---------------------- TICKS ----------------------- */
#define  OS_CFG_TICK_RATE_HZ                        1000
#define  OS_CFG_TICK_TASK_PRIO                        2
#define  OS_CFG_TICK_TASK_STK_SIZE                   256


                                                                /* --------------------- TIMERS ----------------------- */
#define  OS_CFG_TMR_TASK_PRIO        3
#define  OS_CFG_TMR_TASK_RATE_HZ                      10
#define  OS_CFG_TMR_TASK_STK_SIZE                    256

#endif
