#include "xparameters.h"
#include "xscugic.h"
#include "xil_exception.h"

#define INTC_GPIO_INTERRUPT_ID  XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR
XScuGic INTCInst;

int InterruptSystemSetup(XScuGic *XScuGicInstancePtr)
{
	// Register GIC interrupt handler
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler,XScuGicInstancePtr);
    Xil_ExceptionEnable();
    return XST_SUCCESS;

}

int InterruptInit(u16 DeviceId)
{

	XScuGic_Config *IntcConfig;
	int status;
	// Interrupt controller initialization
    IntcConfig = XScuGic_LookupConfig(DeviceId);
    status = XScuGic_CfgInitialize(&INTCInst, IntcConfig, IntcConfig->CpuBaseAddress);
    if(status != XST_SUCCESS) return XST_FAILURE;

    // Call interrupt setup function
    status = InterruptSystemSetup(&INTCInst);
    if(status != XST_SUCCESS) return XST_FAILURE;
    return XST_SUCCESS;
}

int InterruptConnect(u32 Int_Id,void *CallBackRef,void * Handler)
{
	int status;
	// Register GPIO interrupt handler
	status = XScuGic_Connect(&INTCInst,Int_Id,(Xil_InterruptHandler)Handler,CallBackRef);
	if(status != XST_SUCCESS) return XST_FAILURE;
	XScuGic_Enable(&INTCInst, Int_Id);
	return XST_SUCCESS;
}


