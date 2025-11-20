#include <stdint.h>
#include "svdpi.h"

// Compile
// gcc -fPIC -shared -o crc16_ref.so crc16.c
// gcc -m32 -fPIC -shared -o crc16_ref.so crc16.c

uint16_t crc16_ref_c(uint8_t data_input, uint16_t crc_prev) {
    uint16_t crc_next;
    uint8_t feedback;

    feedback = ((crc_prev >> 15) & 1) ^ (data_input & 1);
    crc_next = (crc_prev << 1) & 0xFFFF;  // сдвиг влево на 1 бит, 16 бит маска

    crc_next ^= feedback;          // xor в младший бит
    crc_next ^= (feedback << 2);   // xor 3-й бит
    crc_next ^= (feedback << 15);  // xor 16-й бит

    return crc_next;
}
