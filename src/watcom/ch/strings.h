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


/* Microsoft has no <strings.h>, supply our own that is
 * a subset of of Watcom's <strings.h>
 */

#if defined(_MSC_VER) || defined(__WATCOMC__)
/* Allow Watcom bootstrap builds to use this (building with cl). */

#ifdef __WATCOMC__
#ifndef __COMDEF_H_INCLUDED
 #include <_comdef.h>
#endif
#else
#define _WCRTLINK
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Non-legacy functions */

_WCRTLINK extern int    ffs( int i );
_WCRTLINK extern int    strcasecmp( const char *s1, const char *s2 );
_WCRTLINK extern int    strncasecmp( const char *s1, const char *s2, size_t n );

#ifdef __cplusplus
} /* extern "C" */
#endif

#else
#error This header is only intended for Microsoft C!
#endif
