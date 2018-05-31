#########################################################################################################
#                                           MICRIUM XSDK REPOSITORY
#                          (c) Copyright 2014-2015; Micrium, Inc.; Weston, FL
#
#               All rights reserved.  Protected by international copyright laws.
#########################################################################################################

COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libucos.a

CC_FLAGS = $(COMPILER_FLAGS)
ECC_FLAGS = $(EXTRA_COMPILER_FLAGS)

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

OUTS = *.o

include ../../../include/Makefile_def.inc
include Makefile.inc

DIST_LIB=libucopenamp-${UCOS_OS}-${UCOS_ARCH}.a

LIBSOURCES:=openamp/source/hil.c \
            openamp/source/llist.c \
            openamp/source/sh_mem.c \
            openamp/source/remote_device.c \
            openamp/source/rpmsg.c \
            openamp/source/rpmsg_core.c \
            openamp/source/remoteproc.c \
            openamp/source/rsc_table_parser.c \
            openamp/source/virtio.c \
            openamp/source/virtqueue.c \
            openamp/source/openamp_micrium_core.c \
            config.c \
            rsc_table.c \
            platform_info.c
            
LIBSOURCES += $(ARCH_LIBSOURCES)

INCLUDEFILES:=config.h \
              rsc_table.h

INCLUDEFILES += $(ARCH_INCLUDEFILES)

ifeq (${strip ${UCOS_OPENAMP_SRC_BASE}},)
OBJECTS =
else
OBJECTS = $(addsuffix .o, $(basename ${LIBSOURCES}))
endif

libs: banner lib_copy ucos_final_libs clean

%.o: %.c
	${MKDIR} -p $(@D)
	${COMPILER} $(CC_FLAGS) $(ECC_FLAGS) $(INCLUDES) -o $@ $<

%.o: %.S
	${MKDIR} -p $(@D)
	${COMPILER} $(CC_FLAGS) $(ECC_FLAGS) $(INCLUDES) -o $@ $<

banner:
	echo "Compiling OpenAMP"
	
lib_copy:
ifeq (${strip ${UCOS_OPENAMP_SRC_BASE}},)
	echo "OpenAMP sources not found, using pre-compiled library"
	${CP} ${UCOS_LIB_LOC}/${DIST_LIB} ${RELEASEDIR}/
	touch ${RELEASEDIR}/${DIST_LIB}
else
	echo "Building OpenAMP from sources at ${UCOS_OPENAMP_SRC_BASE}"
endif

${RELEASEDIR}/${DIST_LIB}: ${OBJECTS}
		$(ARCHIVER) -cr ${RELEASEDIR}/${DIST_LIB} ${OBJECTS}
	
ucos_final_libs: ${RELEASEDIR}/${DIST_LIB}
		rm -rf ${OBJECTS}
		$(ARCHIVER) -x ${RELEASEDIR}/${DIST_LIB}
		$(ARCHIVER) -r ${RELEASEDIR}/${LIB} *.o
		rm -rf *.o
		
bsp: ${BSPOBJECTS}
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${BSPOBJECTS}

.PHONY: include
include:
	${CP} ${INCLUDEFILES} ${INCLUDEDIR}
	${CP} ${UCOS_SRC_BASE}/openamp/source/hil.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/llist.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/sh_mem.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/include/open_amp.h ${INCLUDEDIR}/include/
	${CP} ${UCOS_SRC_BASE}/openamp/source/rpmsg.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/rpmsg_core.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/remoteproc.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/rsc_table_parser.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/virtio.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/virtio_ring.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/virtqueue.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/source/env.h ${INCLUDEDIR}/source/
	${CP} ${UCOS_SRC_BASE}/openamp/include/openamp_micrium_core.h ${INCLUDEDIR}/include/

clean:
	rm -rf ${OBJECTS}

