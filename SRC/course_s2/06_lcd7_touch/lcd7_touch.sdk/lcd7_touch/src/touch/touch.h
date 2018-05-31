#include "xil_types.h"


#ifndef TOUCH_H_
#define TOUCH_H_

int touch_init (void);
int touch_i2c_read_bytes(u8 *BufferPtr, u8 address, u16 ByteCount);

u8 touch_sig;

#endif /* TOUCH_H_ */
