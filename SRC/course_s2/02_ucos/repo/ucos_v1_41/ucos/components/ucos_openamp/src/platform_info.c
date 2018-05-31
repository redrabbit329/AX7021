/*
 * Copyright (c) 2014, Mentor Graphics Corporation
 * All rights reserved.
 * Copyright (c) 2015 Micrium Inc. All rights reserved.
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
 *       platform_info.c
 *
 * DESCRIPTION
 *
 *       This file implements APIs to get platform specific
 *       information for OpenAMP.
 *
 **************************************************************************/

#include <lib_def.h>
#include "platform.h"
#include "xparameters.h"

extern struct hil_platform_ops proc_ops;

/* IPC Device parameters */
#define SHM_ADDR                          (void *)0x40060000
#define SHM_SIZE                          0x20000
#define VRING0_IPI_VECT                   14
#define VRING1_IPI_VECT                   15
#define MASTER_CPU_ID                     0
#define REMOTE_CPU_ID                     1

/**
 * This array provdes defnition of CPU nodes for master and remote
 * context. It contains two nodes beacuse the same file is intended
 * to use with both master and remote configurations. On zynq platform
 * only one node defintion is required for master/remote as there
 * are only two cores present in the platform.
 *
 * Only platform specific info is populated here. Rest of information
 * is obtained during resource table parsing.The platform specific
 * information includes;
 *
 * -CPU ID
 * -Shared Memory
 * -Interrupts
 * -Channel info.
 *
 * Although the channel info is not platform specific information
 * but it is conveneient to keep it in HIL so that user can easily
 * provide it without modifying the generic part.
 *
 */
struct hil_proc proc_table []=
{
#if (OPENAMP_ZYNQ_AMP_CORE_0_EN == DEF_ENABLED)
    {   OPENAMP_ZYNQ_AMP_CORE_0_ID, /* CPU ID of Zynq core 0 */
        { (void *)OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_ADDR, OPENAMP_ZYNQ_AMP_CORE_0_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
             0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_ZYNQ_AMP_CORE_0_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_ZYNQ_AMP_CORE_0_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, }, /* .ops: HIL platform ops table. */
#endif

#if (OPENAMP_ZYNQ_AMP_CORE_1_EN == DEF_ENABLED)
    {   OPENAMP_ZYNQ_AMP_CORE_1_ID, /* CPU ID of Zynq core 1 */
        { (void *)OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_ADDR, OPENAMP_ZYNQ_AMP_CORE_1_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
            0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_ZYNQ_AMP_CORE_1_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_ZYNQ_AMP_CORE_1_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, }, /* .ops: HIL platform ops table. */
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_0_EN == DEF_ENABLED)
    {   OPENAMP_MICROBLAZE_AMP_CORE_0_ID, /* CPU ID of MicroBlaze core 0 */
        { (void *)OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_0_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
            0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_0_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_0_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, } /* .ops: HIL platform ops table. */
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_1_EN == DEF_ENABLED)
    {   OPENAMP_MICROBLAZE_AMP_CORE_1_ID, /* CPU ID of MicroBlaze core 1 */
        { (void *)OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_1_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
            0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_1_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_1_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, } /* .ops: HIL platform ops table. */
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_2_EN == DEF_ENABLED)
    {   OPENAMP_MICROBLAZE_AMP_CORE_2_ID, /* CPU ID of MicroBlaze core 2 */
        { (void *)OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_2_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
            0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_2_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_2_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, } /* .ops: HIL platform ops table. */
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_3_EN == DEF_ENABLED)
    {   OPENAMP_MICROBLAZE_AMP_CORE_3_ID, /* CPU ID of MicroBlaze core 3 */
        { (void *)OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_3_SHMEM_SIZE }, /* .sh_buff: Shared memory info */
        { /* .vdev: VirtIO device info */
            0, 0, 0, /* .num_vrings, dfeatures, gfeatures */
            { { /* .vring_info[0]: Ring 0 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_3_TX_INTR, 0x01, 1, NULL } }, /* .vect_id, .priority, .trigger_type. .data */
                { /* .vring_info[1]: Ring 1 */
                    NULL, NULL, 0, 0, /* .vq, .phy_addr, .num_descs */
                    { OPENAMP_MICROBLAZE_AMP_CORE_3_RX_INTR, 0x01, 1, NULL } /* .vect_id, .priority, .trigger_type. .data */
                } } }, 1, /* .num_chnls: Number of RPMSG channels */
        { /* .chnls[0]: RPMSG channel info */
            {"dflt"} }, /* .name */
        &proc_ops, } /* .ops: HIL platform ops table. */
#endif
};

/**
 * platform_get_processor_info
 *
 * Copies the target info from the user defined data structures to
 * HIL proc  data structure.In case of remote contexts this function
 * is called with the reserved CPU ID HIL_RSVD_CPU_ID, because for
 * remotes there is only one master.
 *
 * @param proc   - HIL proc to populate
 * @param cpu_id - CPU ID
 *
 * return  - status of execution
 */
int platform_get_processor_info(struct hil_proc *proc , int cpu_id) {
    int idx;


    if (cpu_id == HIL_RSVD_CPU_ID) {
        cpu_id = OPENAMP_CFG_MASTER_ID;
    }

    for(idx = 0; idx < sizeof(proc_table)/sizeof(struct hil_proc); idx++) {
        if((proc_table[idx].cpu_id == cpu_id) ) {
            Mem_Copy(proc,&proc_table[idx], sizeof(struct hil_proc));
            return 0;
        }
    }
    return -1;
}

int platform_get_processor_for_fw(char *fw_name) {

    if (Str_Cmp_N(fw_name, "ps7_cortexa9_0", sizeof("ps7_cortexa9_0")) == 0) {
#if (OPENAMP_ZYNQ_AMP_CORE_0_EN == DEF_ENABLED)
        return OPENAMP_ZYNQ_AMP_CORE_0_ID;
#else
        return -1;
#endif
    } else if (Str_Cmp_N(fw_name, "ps7_cortexa9_1", sizeof("ps7_cortexa9_1")) == 0) {
#if (OPENAMP_ZYNQ_AMP_CORE_1_EN == DEF_ENABLED)
        return OPENAMP_ZYNQ_AMP_CORE_1_ID;
#else
        return -1;
#endif
    } else if (Str_Cmp_N(fw_name, "microblaze_0", sizeof("microblaze_0")) == 0) {
#if (OPENAMP_MICROBLAZE_AMP_CORE_0_EN == DEF_ENABLED)
        return OPENAMP_MICROBLAZE_AMP_CORE_0_ID;
#else
        return -1;
#endif
    } else if (Str_Cmp_N(fw_name, "microblaze_1", sizeof("microblaze_1")) == 0) {
#if (OPENAMP_MICROBLAZE_AMP_CORE_1_EN == DEF_ENABLED)
        return OPENAMP_MICROBLAZE_AMP_CORE_1_ID;
#else
        return -1;
#endif
    } else if (Str_Cmp_N(fw_name, "microblaze_2", sizeof("microblaze_2")) == 0) {
#if (OPENAMP_MICROBLAZE_AMP_CORE_2_EN == DEF_ENABLED)
        return OPENAMP_MICROBLAZE_AMP_CORE_2_ID;
#else
        return -1;
#endif
    } else if (Str_Cmp_N(fw_name, "microblaze_3", sizeof("microblaze_3")) == 0) {
#if (OPENAMP_MICROBLAZE_AMP_CORE_3_EN == DEF_ENABLED)
        return OPENAMP_MICROBLAZE_AMP_CORE_3_ID;
#else
        return -1;
#endif
    } else {
        return -1;
    }
}
