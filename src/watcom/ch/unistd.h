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
* Description:  Compatibility header for Microsoft C.
*
****************************************************************************/


/* We have hundreds of source files that can be built with Microsoft C
 * except for one difference, which is that everyone uses <unistd.h> but
 * Microsoft only has <io.h>. Instead of placing #ifdef directives in
 * all those files, we try to account for the difference here.
 */

#if defined(_MSC_VER)
#include <io.h>
#include <direct.h> /* For getcwd() and such. */

/* Also define some constants that Microsoft inexplicably lacks. */
/* Constants for access(). */
#define F_OK    0
#define W_OK    2
#define R_OK    4

/* Watcom has these in <io.h> but Microsoft doesn't */
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2

extern int    getopt( int argc, char * const argv[], const char *optstring );
extern char   *optarg;
extern int    optind;
extern int    opterr;
extern int    optopt;

#elif defined(__WATCOMC__)

/* Allow Watcom bootstrap builds to use this (building with cl). */
#include <io.h>
#include <direct.h>
/* If we include <io.h> we'll miss getopt() prototype and friends.
 * This is ugly but if we included this header, we can no longer include
 * the real <unistd.h>.
 */
_WCRTLINK extern int    getopt( int __argc, char * const __argv[], const char *__optstring );
_WCRTDATA extern char   *optarg;
_WCRTDATA extern int    optind;
_WCRTDATA extern int    opterr;
_WCRTDATA extern int    optopt;

#else
#error This header is only intended for Microsoft C!
#endif
