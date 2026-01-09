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
* Description:  Comparisons of the objects pointed to
*
****************************************************************************/

#ifndef PTROPS_INCLUDED
#define PTROPS_INCLUDED

// Microsoft's newer C++ compilers lie and report old __cplusplus unless
// a /Zc:__cplusplus switch is used. But Watcom's CL front end does not
// support /Zc, so we don't want to use the switch on the command line.
// Instead, we can check the _MSVC_LANG macro.
#if __cplusplus >= 201103L
#define HAVE_CPP_11
#elif _MSVC_LANG >= 201103L
#define HAVE_CPP_11
#else
#undef HAVE_CPP_11
#endif

template < class Type >
#ifndef HAVE_CPP_11
struct ptrEqualTo : std::binary_function< Type, Type, bool > {
#else
struct ptrEqualTo {
#endif
    bool operator( )( const Type &x, const Type &y ) const
        { return( *x == *y ); }
};

template < class Type >
#ifndef HAVE_CPP_11
struct ptrLess : std::binary_function< Type, Type, bool > {
#else
struct ptrLess {
#endif
    bool operator( )( const Type &x, const Type &y ) const
        { return( *x < *y ); }
};

template < class Type >
#ifndef HAVE_CPP_11
struct ptrGreater : std::binary_function< Type, Type, bool > {
#else
struct ptrGreater {
#endif
    bool operator( )( const Type &x, const Type &y ) const
        { return( *x > *y ); }
};

#endif //PTROPS_INCLUDED
