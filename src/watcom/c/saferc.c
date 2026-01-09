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
* Description:  A minimal Safer C implementation for other compilers.
*
****************************************************************************/


#if !defined(__STDC_LIB_EXT1__) && !defined(_MSC_VER)

#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <time.h>
#include "saferc.h"

/* stdio.h subset */
errno_t fopen_s( FILE **streamptr, const char *filename, const char *mode )
{
    char    f_mode[16];

    if ( *mode == 'u' )
        strcpy_s( f_mode, sizeof( f_mode ), mode + 1 );
    else
        strcpy_s( f_mode, sizeof( f_mode ), mode );

    *streamptr = fopen( filename, f_mode );
    if( *streamptr ) 
        return( 0 );
    else
        return( -1 );
}

int     fprintf_s( FILE *stream, const char *format, ... )
{
    va_list     args;

    va_start( args, format );
    return( vfprintf( stream, format, args ) );
}

int     sprintf_s( char *s, rsize_t n, const char *format, ... )
{
    va_list     args;

    va_start( args, format );
    return( vsprintf( s, format, args ) );
}

int     vprintf_s( const char *format, va_list arg )
{
    return( vprintf( format, arg ) );
}

int     vfprintf_s( FILE *stream, const char *format, va_list arg )
{
    return( vfprintf( stream, format, arg ) );
}

/* stdlib.h subset */
errno_t getenv_s( size_t *len, char *value, rsize_t maxsize, const char *name )
{
    const char  *val;

    val = getenv( name );
    if( val ) {
        size_t  sl = strlen( val ) + 1;
        if( value ) 
            strncpy_s( value, maxsize, val, sl );
        *len = sl;
    } else {
        *len = 0;
    }
    return( 0 );
}

/* string.h subset */
errno_t strcpy_s( char *s1, rsize_t s1max, const char *s2 )
{
    strcpy( s1, s2 );
    return( 0 );
}

errno_t strncpy_s( char *s1, rsize_t s1max, const char *s2, rsize_t n )
{
    for( ; n; --n ) {
        if( *s2 == '\0' )
            break;
        *s1++ = *s2++;
    }
    *s1 = '\0';

    return( 0 );
}

errno_t strcat_s( char *s1, rsize_t s1max, const char *s2 )
{
    strcat( s1, s2 );
    return( 0 );
}

size_t  strnlen_s( const char *s, size_t maxsize )
{
    size_t  m = 0;

    if( s != NULL ) {
        while( *(s + m) != '\0' && m < maxsize )
            ++m;
    }
    return( m );
}

errno_t memmove_s( void *s1, rsize_t s1max, const void *s2, rsize_t n )
{
    memmove( s1, s2, n );
    return( 0 );
}

errno_t memcpy_s( void *s1, rsize_t s1max, const void *s2, rsize_t n )
{
    memcpy( s1, s2, n );
    return( 0 );
}

errno_t strerror_s( char *s, size_t maxsize, errno_t errnum )
{
    const char  *ers;

    ers = strerror( errnum );
    strncpy_s( s, maxsize, ers, strlen( ers ) + 1 );
    return( 0 );
}

/* time.h subset */
struct tm *localtime_s( const time_t *timer, struct tm *t )
{
    struct tm   *tms;

    tms = localtime( timer );
    if( tms ) {
        *t = *tms;
        return( t );
    } else {
        return( NULL );
    }
}

#endif
