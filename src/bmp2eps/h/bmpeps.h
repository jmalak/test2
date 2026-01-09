#ifndef __BMPEPS_H__
#define __BMPEPS_H__

#include <stdio.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#include "pushpck1.h"

typedef struct bmp_file_header {
    uint16_t    type;
    uint32_t    size;
    uint16_t    reserved1;
    uint16_t    reserved2;
    uint32_t    off_bits;
} bmp_file_header;

typedef struct bmp_info_header {
    uint32_t    size;
    int32_t     width;
    int32_t     height;
    uint16_t    planes;
    uint16_t    bit_count;
    uint32_t    compression;
    uint32_t    size_image;
    int32_t     x_ppm;
    int32_t     y_ppm;
    uint32_t    clr_used;
    uint32_t    clr_important;
} bmp_info_header;

#include "poppck.h"

typedef struct bmp_rgb_quad {
    unsigned char   blue;
    unsigned char   green;
    unsigned char   red;
    unsigned char   reserved;
} bmp_rgb_quad;

typedef struct bmp_rgb_triplet {
    unsigned char   blue;
    unsigned char   green;
    unsigned char   red;
} bmp_rgb_triplet;

int bmeps_bmp(FILE *out, FILE *in, char *name);
int bmeps_bmp_bb(FILE *out, FILE *in, char *name);
int bmeps_bmp_wh(FILE *in, unsigned long *w, unsigned long *h);

#ifdef __cplusplus
}
#endif

#endif

