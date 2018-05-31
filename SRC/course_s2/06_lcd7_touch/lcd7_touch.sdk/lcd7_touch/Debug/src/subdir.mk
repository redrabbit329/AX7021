################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/PS_timer.c \
../src/display_demo.c \
../src/ugui.c \
../src/zynq_interrupt.c 

OBJS += \
./src/PS_timer.o \
./src/display_demo.o \
./src/ugui.o \
./src/zynq_interrupt.o 

C_DEPS += \
./src/PS_timer.d \
./src/display_demo.d \
./src/ugui.d \
./src/zynq_interrupt.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../lcd7_touch_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


