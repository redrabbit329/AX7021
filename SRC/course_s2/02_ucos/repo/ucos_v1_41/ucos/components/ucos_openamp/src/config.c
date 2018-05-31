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
 *       config.c
 *
 * COMPONENT
 *
 *         OpenAMP stack.
 *
 * DESCRIPTION
 *
 *
 **************************************************************************/

#include <lib_def.h>
#include <config.h>
#include <xparameters.h>

/* Hardcoded Firmware image address. This memory area will be properly filled by the linker and
 * the debugger. The loaded image is compiled in the "OS3_openamp_remote_cpu1" project.
 * The addresses come from the scatter file.
 */
/* Init firmware table */

#if (OPENAMP_ZYNQ_AMP_CORE_0_EN == DEF_ENABLED)
extern const struct remote_resource_table ps7_core0_resources;
#endif

#if (OPENAMP_ZYNQ_AMP_CORE_1_EN == DEF_ENABLED)
extern const struct remote_resource_table ps7_core1_resources;
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_0_EN == DEF_ENABLED)
extern const struct remote_resource_table mb_core0_resources;
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_1_EN == DEF_ENABLED)
extern const struct remote_resource_table mb_core1_resources;
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_2_EN == DEF_ENABLED)
extern const struct remote_resource_table mb_core2_resources;
#endif

#if (OPENAMP_MICROBLAZE_AMP_CORE_3_EN == DEF_ENABLED)
extern const struct remote_resource_table mb_core3_resources;
#endif

const struct firmware_info fw_table[] = {
#if (OPENAMP_ZYNQ_AMP_CORE_0_EN == DEF_ENABLED)
    {
        "ps7_cortexa9_0",
        &ps7_core0_resources,
        1024
    },
#endif
#if (OPENAMP_ZYNQ_AMP_CORE_1_EN == DEF_ENABLED)
    {
        "ps7_cortexa9_1",
        &ps7_core1_resources,
        1024
    },
#endif
#if (OPENAMP_MICROBLAZE_AMP_CORE_0_EN == DEF_ENABLED)
    {
        "microblaze_0",
        &mb_core0_resources,
        1024
    },
#endif
#if (OPENAMP_MICROBLAZE_AMP_CORE_1_EN == DEF_ENABLED)
    {
        "microblaze_1",
        &mb_core1_resources,
        1024
    },
#endif
#if (OPENAMP_MICROBLAZE_AMP_CORE_2_EN == DEF_ENABLED)
    {
        "microblaze_2",
        &mb_core2_resources,
        1024
    },
#endif
#if (OPENAMP_MICROBLAZE_AMP_CORE_3_EN == DEF_ENABLED)
    {
        "microblaze_3",
        &mb_core3_resources,
        1024
    },
#endif
};

/**
 * config_get_firmware
 *
 * Searches the given firmware in firmware table list and provides
 * it to caller.
 *
 * @param fw_name    - name of the firmware
 * @param start_addr - pointer t hold start address of firmware
 * @param size       - pointer to hold size of firmware
 *
 * returns -  status of function execution
 *
 */

int config_get_firmware(char *fw_name, const void **rsc_tbl_ptr, unsigned int *size) {
    int idx;
    for (idx = 0; idx < sizeof(fw_table) / (sizeof(struct firmware_info));
                    idx++) {
        if (!Str_Cmp_N((char *) fw_table[idx].name, fw_name,
                        sizeof(fw_table[idx].name))) {
            *rsc_tbl_ptr = fw_table[idx].rsc_tble;
            *size = fw_table[idx].size;
            return 0;
        }
    }
    return -1;
}
