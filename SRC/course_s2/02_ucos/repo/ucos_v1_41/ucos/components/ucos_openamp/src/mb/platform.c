/*
 * Copyright (c) 2014, Mentor Graphics Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of Mentor Graphics Corporation nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/**************************************************************************
 * FILE NAME
 *
 *       platform.c
 *
 * DESCRIPTION
 *
 *       This file is the Implementation of IPC hardware layer interface
 *       for Xilinx Zynq ZC702EVK platform.
 *
 **************************************************************************/

#include "platform.h"

#include <cpu.h>

void UCOS_OpenAMP_Notify (int cpu_id, struct proc_intr *intr_info) __attribute__ ((weak));

/*--------------------------- Globals ---------------------------------- */
struct hil_platform_ops proc_ops = {
    .enable_interrupt   = _enable_interrupt,
    .notify             = _notify,
    .boot_cpu           = _boot_cpu,
    .shutdown_cpu       = _shutdown_cpu,
};

int _enable_interrupt(struct proc_vring *vring_hw) {

    /* Register ISR*/
    env_register_isr(vring_hw->intr_info.vect_id, vring_hw, platform_isr);

    /* Enable the interrupts */
    env_enable_interrupt(vring_hw);

    return 0;
}

void _notify(int cpu_id, struct proc_intr *intr_info) {
    UCOS_OpenAMP_Notify(cpu_id, intr_info);
}

int _boot_cpu(int cpu_id, unsigned int load_addr) {


    return 0;
}

void _shutdown_cpu(int cpu_id) {

}

void platform_isr(void *data) {
    hil_isr(((struct proc_vring *) data));
}
