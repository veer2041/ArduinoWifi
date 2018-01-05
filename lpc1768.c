/*****************************************************************************
 *   uarttest.c:  main C entry file for NXP LPC17xx Family Microprocessors
 *
 *   Copyright(C) 2009, NXP Semiconductor
 *   All rights reserved.
 *
 *   History
 *   2009.05.27  ver 1.00    Prelimnary version, first Release
 *
******************************************************************************/
#include "lpc17xx.h"
#include "type.h"
#include "uart.h"
#include "string.h"

extern volatile uint32_t UART3Count;
extern volatile uint8_t UART3Buffer[BUFSIZE];
extern volatile uint32_t UART2Count;
extern volatile uint8_t UART2Buffer[BUFSIZE];
extern volatile uint32_t UART1Count;
extern volatile uint8_t UART1Buffer[BUFSIZE];
extern volatile uint32_t UART0Count;
extern volatile uint8_t UART0Buffer[BUFSIZE];

void delay_ms( int val)
{
	int i;
	int j;
	for(i = 0 ; i < val ; i++ )
	{
		for(j = 0 ; j < 10000 ; j++ ) ;
	}
	return ;
}

signed int tp_strcmp( unsigned char *s1, unsigned char *s2)
{
   for (; *s1 == *s2; s1++, s2++)
      if (*s1 == '\0')
         return(0);
   return((*s1 < *s2) ? -1: 1);
}
/*****************************************************************************
**   Main Function  main()
This program has been test on Keil LPC1700 board.
*****************************************************************************/
int main (void)
{
  unsigned char string_rec[5];
  short int i=0;

  SystemInit();
  UARTInit(0,9600);	/* baud rate setting */
 
  UARTInit(1,115200);	/* baud rate setting */
  

  																  
	 UARTSend( 0, (uint8_t *)UART1Buffer, UART0Count );
	 	UART1Count=0;
  //delay_ms(250);
  while (1) 
  {			
  	  UARTSend( 1, "AT", sizeof("AT"));	
	
	if ( UART1Count != 0 )
	{
	  LPC_UART1->IER = IER_THRE | IER_RLS;		//	 Disable RBR 
	  delay_ms(250);
	  delay_ms(1000);
	  UARTSend( 0, (uint8_t *)UART1Buffer, UART1Count );
	  
	 // string_rec[i++]=UART1Buffer[0];
	 //UARTSend( 0, string_rec[i++], 3 );

	  //UART1Count = 0;
	  LPC_UART1->IER = IER_THRE | IER_RLS | IER_RBR;//	 Re-enable RBR 
	}
	else
	{
	UARTSend( 0, "no", 3 );
	}
	//string_rec[i]='\0';	 
//	if((tp_strcmp(string_rec,"OK")) == 0)
//	{
//		break;
//	}
  }	 
  
}	  

/*****************************************************************************
**                            End Of File
*****************************************************************************/
 
