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


typedef int errno_t;
typedef size_t rsize_t;

/* stdio.h subset */
extern errno_t fopen_s( FILE **streamptr, const char *filename, const char *mode );
extern int     fprintf_s( FILE *stream, const char *format, ... );
extern int     sprintf_s( char *s, rsize_t n, const char *format, ... );
extern int     vprintf_s( const char *format, va_list arg );
extern int     vfprintf_s( FILE *stream, const char *format, va_list arg );

/*stdlib.h subset */
extern errno_t getenv_s( size_t *len, char *value, rsize_t maxsize, const char *name );

/*string.h subset */
extern errno_t strcpy_s( char *s1, rsize_t s1max, const char *s2 );
extern errno_t strncpy_s( char *s1, rsize_t s1max, const char *s2, rsize_t n );
extern errno_t strcat_s( char *s1, rsize_t s1max, const char *s2 );
extern size_t  strnlen_s( const char *s, size_t maxsize );

extern errno_t memmove_s( void *s1, rsize_t s1max, const void *s2, rsize_t n );
extern errno_t memcpy_s( void *s1, rsize_t s1max, const void *s2, rsize_t n );

extern errno_t strerror_s( char *s, size_t maxsize, errno_t errnum );

/*time.h subset */
extern struct tm *localtime_s( const time_t *timer, struct tm *t );
