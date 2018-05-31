/************************************************************************/
/*																		*/
/*	display_demo.c	--	ALINX AX7010 HDMI Display demonstration 						*/
/*																		*/
/************************************************************************/

/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */
#include "display_demo.h"
#include "display_ctrl/display_ctrl.h"
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "pic_800_600.h"
#include "ugui.h"
#include "touch/touch.h"
#include "xscutimer.h"
/*
 * XPAR redefines
 */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VGA_VDMA_ID XPAR_AXIVDMA_0_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID
#define VID_VTC_IRPT_ID XPS_FPGA3_INT_ID
#define VID_GPIO_IRPT_ID XPS_FPGA4_INT_ID
#define SCU_TIMER_ID XPAR_SCUTIMER_DEVICE_ID
#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

/*
 * Display Driver structs
 */
DisplayCtrl dispCtrl;
XAxiVdma vdma;

/*
 * Framebuffers for video data
 */
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME];
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers

u32 *cpFrames;

XScuTimer Timer;//timer

UG_GUI gui ; // Global GUI structure
/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */

u8 ReadBuffer[50];
int touched_x1;
int touched_y1;
int current_x1;
int current_y1;

/* Window 1 */
#define MAX_OBJECTS        10
UG_WINDOW window_1;
UG_OBJECT obj_buff_wnd_1[MAX_OBJECTS];
UG_BUTTON button1_1;
UG_BUTTON button1_2;
UG_BUTTON button1_3;
UG_BUTTON button1_4;
UG_BUTTON button1_5;
UG_BUTTON button1_6;

u8 str[128];
/* Callback function for the main menu */
void window_1_callback( UG_MESSAGE* msg )
{
   if ( msg->type == MSG_TYPE_OBJECT )
   {
      if ( msg->id == OBJ_TYPE_BUTTON )
      {
         switch( msg->sub_id )
         {
            case BTN_ID_0: /* Toggle green LED */
            {
            static UG_U32 i;
            i++;
            sprintf(str,"GR%d\nLED",i);
            UG_ButtonSetText( &window_1, BTN_ID_0, str );
               break;
            }
            case BTN_ID_1: /* Toggle red LED */
            {
            	 static UG_U32 tog;

            	               if ( !tog )
            	               {
            	                  UG_WindowResize( &window_1, 0, 40, 239, 319-40 );
            	               }
            	               else
            	               {
            	                  UG_WindowResize( &window_1, 0, 0, 239, 319 );
            	               }
            	               tog = ! tog;
            	               break;
               break;
            }
            case BTN_ID_2: /* Show µGUI info */
            {
               break;
            }
            case BTN_ID_3: /* Toggle hardware acceleration */
            {
               break;
            }
            case BTN_ID_4: /* Start benchmark */
            {
               break;
            }
            case BTN_ID_5: /* Resize window */
            {
               static UG_U32 tog;

               if ( !tog )
               {
                  UG_WindowResize( &window_1, 0, 40, 239, 319-40 );
               }
               else
               {
                  UG_WindowResize( &window_1, 0, 0, 239, 319 );
               }
               tog = ! tog;
               break;
            }
         }
      }
   }
}


void PixelSet(UG_S16 x , UG_S16 y ,UG_COLOR c)
{
	u32 iPixelAddr;
	iPixelAddr = y * 1920  + x;
	cpFrames[iPixelAddr] = c;
}
static void Timer_Handler(void *CallBackRef)

{
    XScuTimer *TimerInstancePtr = (XScuTimer *) CallBackRef;
    XScuTimer_ClearInterruptStatus(TimerInstancePtr);
    XScuTimer_DisableInterrupt(TimerInstancePtr);

    if (touch_sig==1)
    {
    	touch_i2c_read_bytes(ReadBuffer, 0, 20);
    	touch_sig=0;
    	if((ReadBuffer[3] & 0xc0)==0x00)
    	{
    		current_x1=((ReadBuffer[3]&0x3f)<<8) + ReadBuffer[4];
    		current_y1=((ReadBuffer[5]&0x3f)<<8) + ReadBuffer[6];
    		UG_TouchUpdate(current_x1,current_y1,TOUCH_STATE_PRESSED);

    	}
    	else if((ReadBuffer[3] & 0xc0)==0x40)
    	{
    		UG_TouchUpdate(-1,-1,TOUCH_STATE_RELEASED);
    	}

    }
   UG_Update();
   Xil_DCacheFlushRange((unsigned int) dispCtrl.framePtr[dispCtrl.curFrame], DEMO_MAX_FRAME);
   XScuTimer_EnableInterrupt(TimerInstancePtr);
}
int main(void)
{

	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;
	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
	}
	InterruptInit(XPAR_PS7_SCUGIC_0_DEVICE_ID);
	touch_init();
	PS_timer_init(&Timer, XPAR_XSCUTIMER_0_DEVICE_ID ,343 * 10000 - 1);
	InterruptConnect(XPAR_SCUTIMER_INTR,(void *)&Timer,Timer_Handler);
	XScuTimer_EnableInterrupt(&Timer);
	/*
	 * Initialize VDMA driver
	 */
	vdmaConfig = XAxiVdma_LookupConfig(VGA_VDMA_ID);
	if (!vdmaConfig)
	{
		xil_printf("No video DMA found for ID %d\r\n", VGA_VDMA_ID);

	}
	Status = XAxiVdma_CfgInitialize(&vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

	}

	/*
	 * Initialize the Display controller and start it
	 */
	Status = DisplayInitialize(&dispCtrl, &vdma, DISP_VTC_ID, DYNCLK_BASEADDR, pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Display Ctrl initialization failed during demo initialization%d\r\n", Status);

	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Couldn't start display during demo initialization%d\r\n", Status);

	}

	cpFrames =(u32 *)dispCtrl.framePtr[dispCtrl.curFrame];
		UG_Init(&gui , PixelSet, 800 , 480);
		UG_FillScreen ( 0xFF0000 );
		UG_DrawCircle(100 , 100 , 30 , C_WHITE) ;
		Xil_DCacheFlushRange((unsigned int) dispCtrl.framePtr[dispCtrl.curFrame], DEMO_MAX_FRAME);
		   /* Create Window 1 */
		   UG_WindowCreate( &window_1, obj_buff_wnd_1, MAX_OBJECTS, window_1_callback );
		   UG_WindowSetTitleText( &window_1, "µGUI For ALINX AX7020!" );
		   UG_WindowSetTitleTextFont( &window_1, &FONT_12X20 );

		   /* Create some Buttons */
		   UG_ButtonCreate( &window_1, &button1_1, BTN_ID_0, 10, 10, 110, 60 );
		   UG_ButtonCreate( &window_1, &button1_2, BTN_ID_1, 10, 80, 110, 130 );
		   UG_ButtonCreate( &window_1, &button1_3, BTN_ID_2, 10, 150, 110,200 );
		   UG_ButtonCreate( &window_1, &button1_4, BTN_ID_3, 120, 10, UG_WindowGetInnerWidth( &window_1 ) - 10 , 60 );
		   UG_ButtonCreate( &window_1, &button1_5, BTN_ID_4, 120, 80, UG_WindowGetInnerWidth( &window_1 ) - 10, 130 );
		   UG_ButtonCreate( &window_1, &button1_6, BTN_ID_5, 120, 150, UG_WindowGetInnerWidth( &window_1 ) - 10, 200 );

		   /* Configure Button 1 */
		   UG_ButtonSetFont( &window_1, BTN_ID_0, &FONT_12X20 );
		   UG_ButtonSetBackColor( &window_1, BTN_ID_0, C_LIME );
		   UG_ButtonSetText( &window_1, BTN_ID_0, "Green\nLED" );
		   /* Configure Button 2 */
		   UG_ButtonSetFont( &window_1, BTN_ID_1, &FONT_12X20 );
		   UG_ButtonSetBackColor( &window_1, BTN_ID_1, C_RED );
		   UG_ButtonSetText( &window_1, BTN_ID_1, "Red\nLED" );
		   /* Configure Button 3 */
		   UG_ButtonSetFont( &window_1, BTN_ID_2, &FONT_12X20 );
		   UG_ButtonSetText( &window_1, BTN_ID_2, "About\nµGUI" );
		   UG_WindowShow( &window_1 );
		   /* Configure Button 4 */
		   UG_ButtonSetFont( &window_1, BTN_ID_3, &FONT_12X20 );
		   UG_ButtonSetForeColor( &window_1, BTN_ID_3, C_RED );
		   UG_ButtonSetText( &window_1, BTN_ID_3, "HW_ACC\nOFF" );
		   /* Configure Button 5 */
		   UG_ButtonSetFont( &window_1, BTN_ID_4, &FONT_8X14 );
		   UG_ButtonSetText( &window_1, BTN_ID_4, "Start\nBenchmark" );
		   /* Configure Button 6 */
		   UG_ButtonSetFont( &window_1, BTN_ID_5, &FONT_10X16 );
		   UG_ButtonSetText( &window_1, BTN_ID_5, "Resize\nWindow" );

		   UG_WindowShow( &window_1 );
		   UG_WaitForUpdate();

		while(1){
			  }

	return 0;
}



