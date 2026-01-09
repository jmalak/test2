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
* Description:  The Control class.
*
****************************************************************************/


#ifndef __CONTROL_H__

#include <set>
#include <string.h>

class Control {
public:
                                Control( const char * text, const char * id, Rect& r )
                                       : _text( text )
                                       , _id( id )
                                       , _rect( r ) {}
                                ~Control(){}

    bool                        operator <( const Control & o ) const {
                                    return( strcmp( _id, o._id ) < 0 );
                                }
    bool                        operator ==( const Control & o ) const {
                                    return( strcmp( _id, o._id ) == 0 );
                                }

    const char *                getText() const { return _text; }
    const char *                getId() const { return _id; }
    const Rect &                getRect() const { return _rect; }

private:
    const char *                _text;
    const char *                _id;
    Rect                        _rect;
};

// This junk is required to get the correct std::less behavior when we
// have std::multiset<Control *> rather than just std::multiset<Control>.
// The latter uses operator < of the Control class, but the former
// just compares pointers.
//
// The old Watcom template library had separate WCValOrderedVector and
// WCPtrOrderedVector classes etc., where the Ptr variant automatically
// used the pointed-to object's operator < rather than just comparing
// the pointers. With the C++ STL there's only one kind of container and
// if the container stores pointers, we need to explicitly override the
// std::less class to do the right thing.
namespace std {
template <>
struct less<Control *>  {
    bool operator()(const Control *lhs, const Control *rhs) const
    {
        return( strcmp( lhs->getId(), rhs->getId() ) < 0 );
    }
};
}

#define __CONTROL_H__
#endif
