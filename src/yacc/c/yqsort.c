/****************************************************************************
*
*                            Open Watcom Project
*
*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
*
*  ========================================================================
*
*    This file contains Original Code and/or Modifications of Original
*    Code as defined in and that are subject to the Sybase Open Watcom
*    Public License version 1.0 (the 'License'). You may not use this file
*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
*    provided with the Original Code and Modifications, and is also
*    available at www.sybase.com/developer/opensource.
*
*    The Original Code and all software distributed under the License are
*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
*    NON-INFRINGEMENT. Please see the License for the specific language
*    governing rights and limitations under the License.
*
*  ========================================================================
*
* Description:  Local qsort() implementation for YACC.
*
****************************************************************************/


/*
 * In order to generate reproducible results, YACC needs a predictable
 * qsort() implementations. The behavior of qsort() differs between C
 * run-time libraries from different versions, and may change between
 * versions.
 *
 * This version was borrowed from the Watcom clib.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "yacc.h"


#ifndef min
    #define min( a, b ) ( ((a)<(b)) ? (a) : (b) )
#endif

/* Support OS/2 16-bit protected mode - will never get stack overflow */
#define MAXDEPTH        (sizeof(long) * 8)

#define SHELL           3       /* Shell constant used in shell sort */

typedef intptr_t WORD;
#define W sizeof( WORD )

/*
    swap() is a macro that chooses between an in_line function call and
    an exchange macro.
*/
#define exch( a, b, t)          ( t = a, a = b, b = t )
#define swap( a, b )    \
    swaptype != 0 ? byteswap( a, b, size ) : \
    ( void ) exch( *( WORD* )( a ), *( WORD* )( b ), t )

/* this is an optimized version of a simple byteswap */
static void byteswap( char *p, char *q, size_t size ) {
    uint32_t    dword;
    uint16_t    word;
    char        byte;

#if 1       /* this is for 32 bit machines */
    while( size > 3 ) {
        dword = *(uint32_t *)p;
        *(uint32_t *)p = *(uint32_t *)q;
        *(uint32_t *)q = dword;
        p += 4;
        q += 4;
        size -= 4;
    }
    if( size > 1 ) {
        word = *(uint16_t *)p;
        *(uint16_t *)p = *(uint16_t *)q;
        *(uint16_t *)q = word;
        p += 2;
        q += 2;
        size -= 2;
    }
#else       /* this is for 16 bit machines */
    while( size > 1 ) {
        word = *(short *)p;
        *(short *)p = *(short *)q;
        *(short *)q = word;
        p += 2;
        q += 2;
        size -= 2;
    }
#endif
    if( size ) {
        byte = *p;
        *p = *q;
        *q = byte;
    }
}

typedef int qcomp( const void *, const void * );

/* Function to find the median value */
static char *med3( char *a, char *b, char *c, qcomp cmp )
{
    if( cmp( a, b ) > 0 ) {
        if( cmp( a, c ) > 0 ) {
            if( cmp( b, c ) > 0 ) {
                return( b );
            } else {
                return( c );
            }
        } else {
            return( a );
        }
    } else {
        if( cmp( a, c ) >= 0 ) {
            return( a );
        } else {
            if( cmp( b, c ) > 0 ) {
                return( c );
            } else {
                return( b );
            }
        }
    }
}

void yacc_qsort( void *a_base, size_t n, size_t size,
                 int (*compar)(const void *, const void *) )
/**********************************************************/
{
    char *base = a_base;
    char *p1, *p2, *pa, *pb, *pc, *pd, *pn, *pv;
    char *mid;
    WORD v, t; /* v is used in pivot initialization, t in exch() macro */
    int  comparison, swaptype, shell;
    size_t r, s;
    unsigned int sp;
    auto char *base_stack[MAXDEPTH];
    auto unsigned int n_stack[MAXDEPTH];
    qcomp *cmp = compar;

    /*
        Initialization of the swaptype variable, which determines which
        type of swapping should be performed when swap() is called.
        0 for single-word swaps, 1 for general swapping by words, and
        2 for swapping by bytes.  W (it's a macro) = sizeof(WORD).
    */
    swaptype = ( ( base - (char *)0 ) | size ) % W ? 2 : size > W ? 1 : 0;
    sp = 0;
    for(;;) {
        while( n > 1 ) {
            if( n < 16 ) {      /* 2-shell sort on smallest arrays */
                for( shell = (size * SHELL) ;
                     shell > 0 ;
                     shell -= ((SHELL-1) * size) ) {
                    p1 = base + shell;
                    for( ; p1 < base + n * size; p1 += shell ) {
                        for( p2 = p1;
                             p2 > base && cmp( p2 - shell, p2 ) > 0;
                             p2 = p2 - shell ) {
                            swap( p2, p2 - shell );
                        }
                    }
                }
                break;
            } else {    /* n >= 16 */
                /* Small array (15 < n < 30), mid element */
                mid = base + (n >> 1) * size;
                if( n > 29 ) {
                    p1 = base;
                    p2 = base + ( n - 1 ) * size;
                    if( n > 42 ) {      /* Big array, pseudomedian of 9 */
                        s = (n >> 3) * size;
                        p1  = med3( p1, p1 + s, p1 + (s << 1), cmp );
                        mid = med3( mid - s, mid, mid + s, cmp );
                        p2  = med3( p2 - (s << 1), p2 - s, p2, cmp );
                    }
                    /* Mid-size (29 < n < 43), med of 3 */
                    mid = med3( p1, mid, p2, cmp );
                }
                /*
                    The following sets up the pivot (pv) for partitioning.
                    It's better to store the pivot value out of line
                    instead of swapping it to base. However, it's
                    inconvenient in C unless the element size is fixed.
                    So, only the important special case of word-size
                    objects has utilized it.
                */
                if( swaptype != 0 ) { /* Not word-size objects */
                    pv = base;
                    swap( pv, mid );
                } else {        /* Storing the pivot out of line (at v) */
                    pv = ( char* )&v;
                    v = *( WORD* )mid;
                }

                pa = pb = base;
                pc = pd = base + ( n - 1 ) * size;
                for(;;) {
                    while(pb <= pc && (comparison = cmp(pb, pv)) <= 0) {
                        if( comparison == 0 ) {
                            swap( pa, pb );
                            pa += size;
                        }
                        pb += size;
                    }
                    while(pc >= pb && (comparison = cmp(pc, pv)) >= 0) {
                        if( comparison == 0 ) {
                            swap( pc, pd );
                            pd = pd - size;
                        }
                        pc = pc - size;
                    }
                    if( pb > pc ) break;
                    swap( pb, pc );
                    pb += size;
                    pc = pc - size;
                }
                pn = base + n * size;
                s = min( pa - base, pb - pa );
                if( s > 0 ) {
                    byteswap( base, pb - s, s );
                }
                s = min( pd - pc, pn - pd - size);
                if( s > 0 ) {
                    byteswap( pb, pn - s, s );
                }
                /* Now, base to (pb-pa) needs to be sorted             */
                /* Also, pn-(pd-pc) needs to be sorted                 */
                /* The middle 'chunk' contains all elements=pivot value*/
                r = pb - pa;
                s = pd - pc;
                if( s >= r ) {  /* Stack up the larger chunk */
                    base_stack[sp] = pn - s;    /* Stack up base           */
                    n_stack[sp] = s / size;     /* Stack up n              */
                    n = r / size;               /* Set up n for next 'call'*/
                                                /* next base is still base */
                } else {
                    if( r <= size ) break;
                    base_stack[sp] = base;      /* Stack up base           */
                    n_stack[sp] = r / size;     /* Stack up n              */
                    base = pn - s;              /* Set up base and n for   */
                    n = s / size;               /* next 'call'             */
                }
                ++sp;
            }
        }
        if( sp == 0 ) break;
        --sp;
        base = base_stack[sp];
        n    = n_stack[sp];
    }
}
