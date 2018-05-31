/*
 * Copyright (c) 2014, Mentor Graphics Corporation
 * All rights reserved.
 * Copyright (c) 2015 Xilinx, Inc. All rights reserved.
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

/* This file populates resource table for BM remote
 * for use by the Linux Master */

#include <stddef.h>
#include <include/open_amp.h>
#include "rsc_table.h"

#include "xparameters.h"

#define RPMSG_IPU_C0_FEATURES       1

/* VirtIO rpmsg device id */
#define VIRTIO_ID_RPMSG_            7

/* Remote supports Name Service announcement */
#define VIRTIO_RPMSG_F_NS           0

#define OCM_0_START                 0xFFFC0000
#define OCM_0_LEN                   0x20000
#define OCM_1_START                 0xFFFF0000
#define OCM_1_LEN                   0x10000

#define NUM_VRINGS                  0x02
#define VRING_ALIGN                 0x1000
#define RING_TX                     0x08000000
#define RING_RX                     0x08100000
#define VRING_SIZE                  256

#define NUM_TABLE_ENTRIES           3
#define CARVEOUT_SRC_OFFSETS        offsetof(struct remote_resource_table, ocm_0_cout), \
                                    offsetof(struct remote_resource_table, ocm_1_cout),

#define CARVEOUT_SRC                {RSC_CARVEOUT, OCM_0_START, OCM_0_START, OCM_0_LEN, 0, 0, "OCM0_COUT",    }, \
                                    {RSC_CARVEOUT, OCM_1_START, OCM_1_START, OCM_1_LEN, 0, 0, "ELF_DATA_COUT",},

#if (OPENAMP_ZYNQ_AMP_CORE_0_EN == DEF_ENABLED)
const struct remote_resource_table ps7_core0_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_ZYNQ_AMP_CORE_0_TX_VRING_ADDR, OPENAMP_ZYNQ_AMP_CORE_0_VRING_ALIGN, OPENAMP_ZYNQ_AMP_CORE_0_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_ZYNQ_AMP_CORE_0_RX_VRING_ADDR, OPENAMP_ZYNQ_AMP_CORE_0_VRING_ALIGN, OPENAMP_ZYNQ_AMP_CORE_0_VRING_SIZE, 2, 0
    },
};
#endif

#if (OPENAMP_ZYNQ_AMP_CORE_1_EN == DEF_ENABLED)
const struct remote_resource_table ps7_core1_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_ZYNQ_AMP_CORE_1_TX_VRING_ADDR, OPENAMP_ZYNQ_AMP_CORE_1_VRING_ALIGN, OPENAMP_ZYNQ_AMP_CORE_1_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_ZYNQ_AMP_CORE_1_RX_VRING_ADDR, OPENAMP_ZYNQ_AMP_CORE_1_VRING_ALIGN, OPENAMP_ZYNQ_AMP_CORE_1_VRING_SIZE, 2, 0
    },
};
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_0_EN == DEF_ENABLED)
const struct remote_resource_table mb_core0_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_MICROBLAZE_AMP_CORE_0_TX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_MICROBLAZE_AMP_CORE_0_RX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_0_VRING_SIZE, 2, 0
    },
};
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_1_EN == DEF_ENABLED)
const struct remote_resource_table mb_core1_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_MICROBLAZE_AMP_CORE_1_TX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_MICROBLAZE_AMP_CORE_1_RX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_1_VRING_SIZE, 2, 0
    },
};
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_2_EN == DEF_ENABLED)
const struct remote_resource_table mb_core2_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_MICROBLAZE_AMP_CORE_2_TX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_MICROBLAZE_AMP_CORE_2_RX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_2_VRING_SIZE, 2, 0
    },
};
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_3_EN == DEF_ENABLED)
const struct remote_resource_table mb_core3_resources =
{
    1, /* .version */

    NUM_TABLE_ENTRIES, /* .num */

    { 0, 0, }, /* .reserved */

    { /* .offset */
        CARVEOUT_SRC_OFFSETS
        offsetof(struct remote_resource_table, rpmsg_vdev),
    },

    CARVEOUT_SRC

    { /* .rpmsg_vdev */
        RSC_VDEV, VIRTIO_ID_RPMSG_, 0, RPMSG_IPU_C0_FEATURES, 0, 0, 0, NUM_VRINGS, {0, 0},
    },

    { /* .rpmsg_vring0 (.rpmsg_vdev.vring[0]) */
        OPENAMP_MICROBLAZE_AMP_CORE_3_TX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_SIZE, 1, 0
    },

    { /* .rpmsg_vring1 (.rpmsg_vdev.vring[1]) */
        OPENAMP_MICROBLAZE_AMP_CORE_3_RX_VRING_ADDR, OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_ALIGN, OPENAMP_MICROBLAZE_AMP_CORE_3_VRING_SIZE, 2, 0
    },
};
#endif

