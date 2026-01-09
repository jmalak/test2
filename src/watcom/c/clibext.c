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
* Description:  Implementation of non-standard functions used by bootstrap
*
****************************************************************************/


#ifdef __WATCOMC__
    /* We don't need any of this stuff, but being able to build this
     * module simplifies makefiles.
     */
#else

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>

#if defined(__UNIX__)
    #include <unistd.h>
    #include <dirent.h>
  #if defined(__QNX__)
    #include <sys/io_msg.h>
  #endif
#else
    #include <io.h>
    #include <time.h>
    #include <direct.h>
  #if defined(__OS2__)
    #include <wos2.h>
  #elif defined(__NT__)
    #include <windows.h>
    #include <mbstring.h>
  #endif
#endif

#include "clibext.h"
#include "wreslang.h"

#define __set_errno( err ) errno = (err)

char **_argv;
int  _argc;

/****************************************************************************
*
* Description:  Shared alphabet array for conversion of integers to ASCII.
*
****************************************************************************/

static const char __Alphabet[] = "0123456789abcdefghijklmnopqrstuvwxyz";


char *utoa( unsigned value, char *buffer, int radix )
{
    char   *p = buffer;
    char        *q;
    unsigned    rem;
    unsigned    quot;
    char        buf[34];    // only holds ASCII so 'char' is OK

    buf[0] = '\0';
    q = &buf[1];
    do {
        rem = value % radix;
        quot = value / radix;
        *q = __Alphabet[rem];
        ++q;
        value = quot;
    } while( value != 0 );
    while( (*p++ = (char)*--q) )
        ;
    return( buffer );
}


char *itoa( int value, char *buffer, int radix )
{
    char   *p = buffer;

    if( radix == 10 ) {
        if( value < 0 ) {
            *p++ = '-';
            value = - value;
        }
    }
    utoa( value, p, radix );
    return( buffer );
}

/****************************************************************************
*
* Description:  Implementation of ltoa().
*
****************************************************************************/

char *ultoa( unsigned long value, char *buffer, int radix )
{
    char   *p = buffer;
    char        *q;
    unsigned    rem;
    char        buf[34];        // only holds ASCII so 'char' is OK

    buf[0] = '\0';
    q = &buf[1];
    do {
        rem = value % radix;
        value = value / radix;
        *q = __Alphabet[rem];
        ++q;
    } while( value != 0 );
    while( (*p++ = (char)*--q) )
        ;
    return( buffer );
}


char *ltoa( long value, char *buffer, int radix )
{
    char   *p = buffer;

    if( radix == 10 ) {
        if( value < 0 ) {
            *p++ = '-';
            value = - value;
        }
    }
    ultoa( value, p, radix );
    return( buffer );
}

/****************************************************************************
*
* Description:  Platform independent _splitpath() implementation.
*
****************************************************************************/

#if defined(__UNIX__)
  #define PC '/'
#else   /* DOS, OS/2, Windows, Netware */
  #define PC '\\'
  #define ALT_PC '/'
#endif

#ifdef __NETWARE__
  #undef _MAX_PATH
  #undef _MAX_SERVER
  #undef _MAX_VOLUME
  #undef _MAX_DRIVE
  #undef _MAX_DIR
  #undef _MAX_FNAME
  #undef _MAX_EXT
  #undef _MAX_NAME

  #define _MAX_PATH    255 /* maximum length of full pathname */
  #define _MAX_SERVER  48  /* maximum length of server name */
  #define _MAX_VOLUME  16  /* maximum length of volume component */
  #define _MAX_DRIVE   3   /* maximum length of drive component */
  #define _MAX_DIR     255 /* maximum length of path component */
  #define _MAX_FNAME   9   /* maximum length of file name component */
  #define _MAX_EXT     5   /* maximum length of extension component */
  #define _MAX_NAME    13  /* maximum length of file name (with extension) */
#endif


static void copypart( char *buf, const char *p, int len, int maxlen )
{
    if( buf != NULL ) {
        if( len > maxlen ) len = maxlen;
            #ifdef __UNIX__
                memcpy( buf, p, len );
                buf[len] = '\0';
            #else
                len = _mbsnccnt( p, len );          /* # chars in len bytes */
                _mbsncpy( buf, p, len );            /* copy the chars */
                buf[ _mbsnbcnt(buf,len) ] = '\0';
            #endif
    }
}

#if !defined(_MAX_NODE)
#define _MAX_NODE   _MAX_DRIVE  /*  maximum length of node name w/ '\0' */
#endif

/* split full QNX path name into its components */

/* Under QNX we will map drive to node, dir to dir, and
 * filename to (filename and extension)
 *          or (filename) if no extension requested.
 */

/* Under Netware, 'drive' maps to 'volume' */

void _splitpath( const char *path,
    char *drive, char *dir, char *fname, char *ext )
{
    const char *dotp;
    const char *fnamep;
    const char *startp;
    unsigned    ch;
#ifdef __NETWARE__
    const char *ptr;
#endif

    /* take apart specification like -> //0/hd/user/fred/filename.ext for QNX */
    /* take apart specification like -> c:\fred\filename.ext for DOS, OS/2 */

#if defined(__UNIX__)

    /* process node/drive specification */
    startp = path;
    if( path[0] == PC  &&  path[1] == PC ) {
        path += 2;
        for( ;; ) {
            if( *path == '\0' ) break;
            if( *path == PC ) break;
            if( *path == '.' ) break;
                #ifdef __UNIX__
                    path++;
                #else
                    path = _mbsinc( path );
                #endif
        }
    }
    copypart( drive, startp, path - startp, _MAX_NODE );

#elif defined(__NETWARE__)

        #ifdef __UNIX__
            ptr = strchr( path, ':' );
        #else
            ptr = _mbschr( path, ':' );
        #endif
    if( ptr != NULL ) {
        if( drive != NULL ) {
            copypart( drive, path, ptr - path + 1, _MAX_SERVER +
                      _MAX_VOLUME + 1 );
        }
            #ifdef __UNIX__
                path = ptr + 1;
            #else
                path = _mbsinc( ptr );
            #endif
    } else if( drive != NULL ) {
        *drive = '\0';
    }

#else

    /* processs drive specification */
    if( path[0] != '\0'  &&  path[1] == ':' ) {
        if( drive != NULL ) {
            drive[0] = path[0];
            drive[1] = ':';
            drive[2] = '\0';
        }
        path += 2;
    } else if( drive != NULL ) {
        drive[0] = '\0';
    }

#endif

    /* process /user/fred/filename.ext for QNX */
    /* process /fred/filename.ext for DOS, OS/2 */
    dotp = NULL;
    fnamep = path;
    startp = path;

    for(;;) {           /* 07-jul-91 DJG -- save *path in ch for speed */
        if( *path == '\0' )  break;
            #ifdef __UNIX__
                ch = *path;
            #else
                ch = _mbsnextc( path );
            #endif
        if( ch == '.' ) {
            dotp = path;
            ++path;
            continue;
        }
            #ifdef __UNIX__
                path++;
            #else
                path = _mbsinc( path );
            #endif
#if defined(__UNIX__)
        if( ch == PC ) {
#else /* DOS, OS/2, Windows, Netware */
        if( ch == PC  ||  ch == ALT_PC ) {
#endif
            fnamep = path;
            dotp = NULL;
        }
    }
    copypart( dir, startp, fnamep - startp, _MAX_DIR - 1 );
    if( dotp == NULL ) dotp = path;
    copypart( fname, fnamep, dotp - fnamep, _MAX_FNAME - 1 );
    copypart( ext,   dotp,   path - dotp,   _MAX_EXT - 1);
}

/****************************************************************************
*
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/

#if defined(__UNIX__)
  #define PC '/'
#else   /* DOS, OS/2, Windows */
  #define PC '\\'
  #define ALT_PC '/'
#endif

/* split full Unix path name into its components */

/* Under Unix we will map drive to node, dir to dir, and
 * filename to (filename and extension)
 *          or (filename) if no extension requested.
 */


static char *pcopy( char **pdst, char *dst, const char *b_src, const char *e_src ) {
/*========================================================================*/

    unsigned    len;

    if( pdst == NULL ) return( dst );
    *pdst = dst;
    len = e_src - b_src;
    if( len >= _MAX_PATH2 )
    {
        len = _MAX_PATH2 - 1;
    }
        #ifdef __UNIX__
            memcpy( dst, b_src, len );
            dst[len] = '\0';
            return( dst + len + 1 );
        #else
            len = _mbsnccnt( b_src, len );          /* # chars in len bytes */
            _mbsncpy( dst, b_src, len );            /* copy the chars */
            dst[ _mbsnbcnt(dst,len) ] = '\0';
            return( dst + _mbsnbcnt(dst,len) + 1 );
        #endif
}

void  _splitpath2( char const *inp, char *outp,
                     char **drive, char **path, char **fn, char **ext ) {
/*=====================================================================*/

    char const *dotp;
    char const *fnamep;
    char const *startp;
    unsigned        ch;

    /* take apart specification like -> //0/hd/user/fred/filename.ext for QNX */
    /* take apart specification like -> \\disk2\fred\filename.ext for UNC names */
    /* take apart specification like -> c:\fred\filename.ext for DOS, OS/2 */

    /* process node/drive/UNC specification */
    startp = inp;
    #ifdef __UNIX__
        if( inp[0] == PC  &&  inp[1] == PC )
    #else
        if( (inp[0] == PC || inp[0] == ALT_PC)
         && (inp[1] == PC || inp[1] == ALT_PC) )
    #endif
    {
        inp += 2;
        for( ;; )
        {
            if( *inp == '\0' )
                break;
            if( *inp == PC )
                break;
            #ifndef __UNIX__
                if( *inp == ALT_PC )
                    break;
            #endif
            if( *inp == '.' )
                break;
                #ifdef __UNIX__
                    inp++;
                #else
                    inp = _mbsinc( inp );
                #endif
        }
        outp = pcopy( drive, outp, startp, inp );
#if !defined(__UNIX__)
    /* process drive specification */
    }
    else if( inp[0] != '\0' && inp[1] == ':' )
    {
        if( drive != NULL )
        {
            *drive = outp;
            outp[0] = inp[0];
            outp[1] = ':';
            outp[2] = '\0';
            outp += 3;
        }
        inp += 2;
#endif
    }
    else if( drive != NULL )
    {
        *drive = outp;
        *outp = '\0';
        ++outp;
    }

    /* process /user/fred/filename.ext for QNX */
    /* process \fred\filename.ext for DOS, OS/2 */
    /* process /fred/filename.ext for DOS, OS/2 */
    dotp = NULL;
    fnamep = inp;
    startp = inp;

    for(;;)
    {
            #ifdef __UNIX__
                ch = *inp;
            #else
                ch = _mbsnextc( inp );
            #endif
        if( ch == 0 )
            break;
        if( ch == '.' )
        {
            dotp = inp;
            ++inp;
            continue;
        }
            #ifdef __UNIX__
                inp++;
            #else
                inp = _mbsinc( inp );
            #endif
#if defined(__UNIX__)
        if( ch == PC )
        {
#else /* DOS, OS/2, Windows */
        if( ch == PC  ||  ch == ALT_PC )
        {
#endif
            fnamep = inp;
            dotp = NULL;
        }
    }
    outp = pcopy( path, outp, startp, fnamep );
    if( dotp == NULL )
        dotp = inp;
    outp = pcopy( fn, outp, fnamep, dotp );
    outp = pcopy( ext, outp, dotp, inp );
}

/****************************************************************************
*
* Description:  Platform independent _makepath() implementation.
*
****************************************************************************/

#undef _makepath

#if defined(__UNIX__)
  #define PC '/'
#else   /* DOS, OS/2, Windows, Netware */
  #define PC '\\'
  #define ALT_PC '/'
#endif


#if defined(__UNIX__)

/* create full Unix style path name from the components */

void _makepath(
        char           *path,
        const char  *node,
        const char  *dir,
        const char  *fname,
        const char  *ext )
{
    *path = '\0';

    if( node != NULL ) {
        if( *node != '\0' ) {
            strcpy( path, node );
            path = strchr( path, '\0' );

            /* if node did not end in '/' then put in a provisional one */
            if( path[-1] == PC )
                path--;
            else
                *path = PC;
        }
    }
    if( dir != NULL ) {
        if( *dir != '\0' ) {
            /*  if dir does not start with a '/' and we had a node then
                    stick in a separator
            */
            if( (*dir != PC) && (*path == PC) ) path++;

            strcpy( path, dir );
            path = strchr( path, '\0' );

            /* if dir did not end in '/' then put in a provisional one */
            if( path[-1] == PC )
                path--;
            else
                *path = PC;
        }
    }

    if( fname != NULL ) {
        if( (*fname != PC) && (*path == PC) ) path++;

        strcpy( path, fname );
        path = strchr( path, '\0' );

    } else {
        if( *path == PC ) path++;
    }
    if( ext != NULL ) {
        if( *ext != '\0' ) {
            if( *ext != '.' )  *path++ = '.';
            strcpy( path, ext );
            path = strchr( path, '\0' );
        }
    }
    *path = '\0';
}

#elif defined( __NETWARE__ )

/*
    For silly two choice DOS path characters / and \,
    we want to return a consistent path character.
*/

static char pickup( char c, char *pc_of_choice )
{
    if( c == PC || c == ALT_PC ) {
        if( *pc_of_choice == '\0' ) *pc_of_choice = c;
        c = *pc_of_choice;
    }
    return( c );
}

extern void _makepath( char *path, const char *volume,
                const char *dir, const char *fname, const char *ext )
{
    char first_pc = '\0';

    if( volume != NULL ) {
        if( *volume != '\0' ) {
            do {
                *path++ = *volume++;
            } while( *volume != '\0' );
            if( path[ -1 ] != ':' ) {
                *path++ = ':';
            }
        }
    }
    *path = '\0';
    if( dir != NULL ) {
        if( *dir != '\0' ) {
            do {
                *path++ = pickup( *dir++, &first_pc );
            } while( *dir != '\0' );
            /* if no path separator was specified then pick a default */
            if( first_pc == '\0' ) first_pc = PC;
            /* if dir did not end in path sep then put in a provisional one */
            if( path[-1] == first_pc ) {
                path--;
            } else {
                *path = first_pc;
            }
        }
    }
    /* if no path separator was specified thus far then pick a default */
    if( first_pc == '\0' ) first_pc = PC;
    if( fname != NULL ) {
        if( (pickup( *fname, &first_pc ) != first_pc)
            && (*path == first_pc) ) path++;
        while( *fname != '\0' ) *path++ = pickup( *fname++, &first_pc );
    } else {
        if( *path == first_pc ) path++;
    }
    if( ext != NULL ) {
        if( *ext != '\0' ) {
            if( *ext != '.' )  *path++ = '.';
            while( *ext != '\0' ) *path++ = *ext++;
        }
    }
    *path = '\0';
}

#else

/*
    For silly two choice DOS path characters / and \,
    we want to return a consistent path character.
*/

static unsigned pickup( unsigned c, unsigned *pc_of_choice )
{
    if( c == PC || c == ALT_PC ) {
        if( *pc_of_choice == '\0' ) *pc_of_choice = c;
        c = *pc_of_choice;
    }
    return( c );
}

/* create full MS-DOS path name from the components */

void _makepath( char *path, const char *drive,
                const char *dir, const char *fname, const char *ext )
{
    unsigned            first_pc = '\0';
    char *              pathstart = path;
    unsigned            ch;

    if( drive != NULL ) {
        if( *drive != '\0' ) {
            if ((*drive == '\\') && (drive[1] == '\\')) {
                strcpy(path, drive);
                path += strlen(drive);
            } else {
                *path++ = *drive;                               /* OK for MBCS */
                *path++ = ':';
            }
        }
    }
    *path = '\0';
    if( dir != NULL ) {
        if( *dir != '\0' ) {
            do {
                    ch = pickup( _mbsnextc(dir), &first_pc );
                    *path = ch; //_mbvtop( ch, path );
                    path[_mbclen(path)] = '\0';
                    path = _mbsinc( path );
                    dir = _mbsinc( dir );
            } while( *dir != '\0' );
            /* if no path separator was specified then pick a default */
            if( first_pc == '\0' ) first_pc = PC;
            /* if dir did not end in '/' then put in a provisional one */
                if( *(_mbsdec(pathstart,path)) == first_pc )
                    path--;
                else
                    *path = first_pc;
        }
    }

    /* if no path separator was specified thus far then pick a default */
    if( first_pc == '\0' ) first_pc = PC;
    if( fname != NULL ) {
            ch = _mbsnextc( fname );
            if( pickup(ch,&first_pc) != first_pc  &&  *path == first_pc )
                path++;

        while (*fname != '\0')
        {
        //do {
                ch = pickup( _mbsnextc(fname), &first_pc );
                *path = ch; //_mbvtop( ch, path );
                path[_mbclen(path)] = '\0';
                path = _mbsinc( path );
                fname = _mbsinc( fname );
        } //while( *fname != '\0' );
    } else {
        if( *path == first_pc ) path++;
    }
    if( ext != NULL ) {
        if( *ext != '\0' ) {
            if( *ext != '.' )  *path++ = '.';
            while( *ext != '\0' ) *path++ = *ext++;     /* OK for MBCS */
        }
    }
    *path = '\0';
}
#endif

#ifndef _MSC_VER    // Microsoft has _fullpath()

/****************************************************************************
*
* Description:  Implementation of fullpath() - returns fully qualified
*               pathname of a file.
*
****************************************************************************/

#define _WILL_FIT( c )  if(( (c) + 1 ) > size ) {       \
                            __set_errno( ERANGE );      \
                            return( NULL );             \
                        }                               \
                        size -= (c);

#ifdef __UNIX__
#define _IS_SLASH( c )  ((c) == '/')
#else
#define _IS_SLASH( c )  (( (c) == '/' ) || ( (c) == '\\' ))
#endif

#if !defined( __NT__ ) && !defined( __NETWARE__ ) && !defined( __UNIX__ )
#pragma on (check_stack);
#endif

#ifdef __NETWARE__
extern char *ConvertNameToFullPath( const char *, char * );
#endif

#if defined(__QNX__)
static char *__qnx_fullpath(char *fullpath, const char *path)
{
    struct {
            struct _io_open _io_open;
            char  m[_QNX_PATH_MAX];
    } msg;
    int             fd;

    msg._io_open.oflag = _IO_HNDL_INFO;
    fd = __resolve_net( _IO_HANDLE, 1, &msg._io_open, path, 0, fullpath );
    if( fd != -1) {
        close(fd);
    } else if (errno != ENOENT) {
        return 0;
    } else {
        __resolve_net( 0, 0, &msg._io_open, path, 0, fullpath );
    }
    return fullpath;
}
#endif

char *_sys_fullpath( char *buff, const char *path, size_t size )
/*********************************************************************/
{

#if defined(__NT__)
    char        *filepart;
    DWORD       rc;

    if( stricmp( path, "con" ) == 0 ) {
        _WILL_FIT( 3 );
        return( strcpy( buff, "con" ) );
    }

    /*** Get the full pathname ***/
    rc = GetFullPathNameA( path, size, buff, &filepart );
    // If the buffer is too small, the return value is the size of
    // the buffer, in TCHARs, required to hold the path.
    // If the function fails, the return value is zero. To get extended error
    // information, call GetLastError.
    if( (rc == 0) || (rc > size) ) {
//        __set_errno_nt();
        return( NULL );
    }

    return( buff );
#elif defined(__WARP__)
    APIRET      rc;
    char        root[4];    /* SBCS: room for drive, ':', '\\', and null */

    if (isalpha( path[0] ) && ( path[1] == ':' )
            && ( path[2] == '\\' ) )
    {
        int i;
        i = strlen( path );
        _WILL_FIT(i);
        strcpy( buff, path );
        return( buff );
    }

    /*
     * Check for x:filename.ext when drive x doesn't exist.  In this
     * case, return x:\filename.ext, not NULL, to be consistent with
     * MS and with the NT version of _fullpath.
     */
    if( isalpha( path[0] )  &&  path[1] == ':' ) {
        /*** We got this far, so path can't start with letter:\ ***/
        root[0] = (char) path[0];
        root[1] = ':';
        root[2] = '\\';
        root[3] = '\0';
        rc = DosQueryPathInfo( root, FIL_QUERYFULLNAME, buff, size );
        if( rc != NO_ERROR ) {
            /*** Drive does not exist; return x:\filename.ext ***/
            _WILL_FIT( strlen( &path[2] ) + 3 );
            buff[0] = root[0];
            buff[1] = ':';
            buff[2] = '\\';
            strcpy( &buff[3], &path[2] );
            return( buff );
        }
    }

    rc = DosQueryPathInfo( (PSZ)path, FIL_QUERYFULLNAME, buff, size );
    if( rc != 0 ) {
        __set_errno_dos( rc );
        return( NULL );
    }
    return( buff );
#elif defined(__QNX__) || defined( __NETWARE__ )
    size_t len;
    char temp_dir[_MAX_PATH];

    #if defined(__NETWARE__)
        if( ConvertNameToFullPath( path, temp_dir ) != 0 ) {
            return( NULL );
        }
    #else
        if( __qnx_fullpath( temp_dir, path ) == NULL ) {
            return( NULL );
        }
    #endif
    len = strlen( temp_dir );
    if( len >= size ) {
        __set_errno( ERANGE );
        return( NULL );
    }
    return( strcpy( buff, temp_dir ) );
#elif defined(__UNIX__)
    const char  *p;
    char        *q;
    size_t      len;
    char        curr_dir[_MAX_PATH];

    p = path;
    q = buff;
    if( ! _IS_SLASH( p[0] ) ) {
        if( getcwd( curr_dir, sizeof(curr_dir) ) == NULL ) {
            __set_errno( ENOENT );
            return( NULL );
        }
        len = strlen( curr_dir );
        _WILL_FIT( len );
        strcpy( q, curr_dir );
        q += len;
        if( q[-1] != '/' ) {
            _WILL_FIT( 1 );
            *(q++) = '/';
        }
        for(;;) {
            if( p[0] == '\0' ) break;
            if( p[0] != '.' ) {
                _WILL_FIT( 1 );
                *(q++) = *(p++);
                continue;
            }
            ++p;
            if( _IS_SLASH( p[0] ) ) {
                /* ignore "./" in directory specs */
                if( ! _IS_SLASH( q[-1] ) ) {
                    *q++ = '/';
                }
                ++p;
                continue;
            }
            if( p[0] == '\0' ) break;
            if( p[0] == '.' && _IS_SLASH( p[1] ) ) {
                /* go up a directory for a "../" */
                p += 2;
                if( ! _IS_SLASH( q[-1] ) ) {
                    return( NULL );
                }
                q -= 2;
                for(;;) {
                    if( q < buff ) {
                        return( NULL );
                    }
                    if( _IS_SLASH( *q ) ) break;
                    --q;
                }
                ++q;
                *q = '\0';
                continue;
            }
            _WILL_FIT( 1 );
            *(q++) = '.';
        }
        *q = '\0';
    } else {
        len = strlen( p );
        _WILL_FIT( len );
        strcpy( q, p );
    }
    return( buff );
#else
    const char *   p;
    char *         q;
    size_t              len;
    unsigned            path_drive_idx;
    char                curr_dir[_MAX_PATH];

    p = path;
    q = buff;
    _WILL_FIT( 2 );
    if( isalpha( p[0] ) && p[1] == ':' ) {
        path_drive_idx = ( tolower( p[0] ) - 'a' ) + 1;
        q[0] = p[0];
        q[1] = p[1];
        p += 2;
    } else {
  #if defined(__OS2__)
        ULONG   drive_map;
        OS_UINT os2_drive;

        if( DosQCurDisk( &os2_drive, &drive_map ) ) {
            __set_errno( ENOENT );
            return( NULL );
        }
        path_drive_idx = os2_drive;
  #else
        path_drive_idx = TinyGetCurrDrive() + 1;
  #endif
        q[0] = 'A' + ( path_drive_idx - 1 );
        q[1] = ':';
    }
    q += 2;
    if( ! _IS_SLASH( p[0] ) ) {
  #if defined(__OS2__)
        OS_UINT dir_len = sizeof( curr_dir );

        if( DosQCurDir( path_drive_idx, curr_dir, &dir_len ) ) {
            __set_errno( ENOENT );
            return( NULL );
        }
  #else
        tiny_ret_t rc;

        rc = TinyGetCWDir( curr_dir, path_drive_idx );
        if( TINY_ERROR( rc ) ) {
            __set_errno( ENOENT );
            return( NULL );
        }
  #endif
        len = strlen( curr_dir );
        if( curr_dir[0] != '\\' ) {
            _WILL_FIT( 1 );
            *(q++) = '\\';
        }
        _WILL_FIT( len );
        strcpy( q, curr_dir );
        q += len;
        if( q[-1] != '\\' ) {
            _WILL_FIT( 1 );
            *(q++) = '\\';
        }
        for(;;) {
            if( p[0] == '\0' ) break;
            if( p[0] != '.' ) {
                _WILL_FIT( 1 );
                *(q++) = *(p++);
                continue;
            }
            ++p;     // at least '.'
            if( _IS_SLASH( p[0] ) ) {
                /* ignore "./" in directory specs */
                if( ! _IS_SLASH( q[-1] ) ) {            /* 14-jan-93 */
                    *q++ = '\\';
                }
                ++p;
                continue;
            }
            if( p[0] == '\0' ) break;
            if( p[0] == '.' ) {  /* .. */
                ++p;
                if( _IS_SLASH( p[0] ) ){ /* "../" */
                    ++p;
                }
                if( ! _IS_SLASH( q[-1] ) ) {
                    return( NULL );
                }
                q -= 2;
                for(;;) {
                    if( q < buff ) {
                        return( NULL );
                    }
                    if( _IS_SLASH( *q ) ) break;
                    if( *q == ':' ) {
                        ++q;
                        *q = '\\';
                        break;
                    }
                    --q;
                }
                ++q;
                *q = '\0';
                continue;
            }
            _WILL_FIT( 1 );
            *(q++) = '.';
        }
        *q = '\0';
    } else {
        len = strlen( p );
        _WILL_FIT( len );
        strcpy( q, p );
    }
    /* force to all backslashes */
    for( q = buff; *q; ++q ) {
        if( *q == '/' ) {
            *q = '\\';
        }
    }
    return( buff );
#endif
}

char *_fullpath( char *buff, const char *path, size_t size )
/**********************************************************/
{
    char *ptr = NULL;

    if( buff == NULL ) {
        size = _MAX_PATH;
        ptr = malloc( size );
        if( ptr == NULL ) __set_errno( ENOMEM );
        buff = ptr;
    }
    if( buff != NULL ) {
        buff[0] = '\0';
        if( path == NULL || path[0] == '\0' ) {
            buff = getcwd( buff, size );
        } else {
            buff = _sys_fullpath( buff, path, size );
        }
        if( buff == NULL ) {
            if( ptr != NULL ) free( ptr );
        }
    }
    return buff;
}

#endif

/****************************************************************************
*
* Description:  Implementation of strlwr(). 
*
****************************************************************************/

 char *strlwr( char *str ) {
    char    *p;
    unsigned char   c;

    p = str;
    while( (c = *p) ) {
        c -= 'A';
        if( c <= 'Z' - 'A' ) {
            c += 'a';
            *p = c;
        }
        ++p;
    }
    return( str );
}
/****************************************************************************
*
* Description:  Implementation of strupr().
*
****************************************************************************/

 char *strupr( char *str ) {
    char    *p;
    unsigned char   c;

    p = str;
    while( (c = *p) ) {
        c -= 'a';
        if( c <= 'z' - 'a' ) {
            c += 'A';
            *p = c;
        }
        ++p;
    }
    return( str );
}

/****************************************************************************
*
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/

int memicmp( const void *in_s1, const void *in_s2, size_t len )
    {
        const unsigned char *   s1 = (const unsigned char *)in_s1;
        const unsigned char *   s2 = (const unsigned char *)in_s2;
        unsigned char           c1;
        unsigned char           c2;

        for( ; len; --len )  {
            c1 = *s1;
            c2 = *s2;
            if( c1 >= 'A'  &&  c1 <= 'Z' )  c1 += 'a' - 'A';
            if( c2 >= 'A'  &&  c2 <= 'Z' )  c2 += 'a' - 'A';
            if( c1 != c2 ) return( c1 - c2 );
            ++s1;
            ++s2;
        }
        return( 0 );    /* both operands are equal */
    }

/****************************************************************************
*
* Description:  Implementation of tell(). 
*
****************************************************************************/

off_t tell( int handle )
{
    return( lseek( handle, 0L, SEEK_CUR ) );
}

#ifndef __NT__	// MSVC has _rotl()

/****************************************************************************
*
* Description:  Implementation of _rotl().
*
****************************************************************************/

unsigned int _rotl( unsigned int value, unsigned int shift )
{
    unsigned int    tmp;

    tmp = value;
    value = value << shift;
    tmp = tmp >> ((sizeof( tmp ) * CHAR_BIT) - shift);
    value = value | tmp;
    return( value );
}

#endif

/****************************************************************************
*
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/

 char *strnset( char *str, int c, size_t len )
    {
        char *p;

        for( p = str; len; --len ) {
            if( *p == '\0' ) break;
            *p++ = c;
        }
        return( str );
    }

/****************************************************************************
*
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/

char *strrev( char *str ) {  /* reverse characters in string */
        char       *p1;
        char       *p2;
        char       c1;
        char       c2;

        p1 = str;
        p2 = p1 + strlen( p1 ) - 1;
        while( p1 < p2 ) {
            c1 = *p1;
            c2 = *p2;
            *p1 = c2;
            *p2 = c1;
            ++p1;
            --p2;
        }
        return( str );
}

/****************************************************************************
*
* Description:  Implements POSIX filelength() function
*
****************************************************************************/

long filelength( int handle )
{
    long                current_posn, file_len;

    current_posn = lseek( handle, 0L, SEEK_CUR );
    if( current_posn == -1L )
    {
        return( -1L );
    }
    file_len = lseek( handle, 0L, SEEK_END );
    lseek( handle, current_posn, SEEK_SET );

    return( file_len );
}

/****************************************************************************
*
* Description:  Implementation of eof().
*
****************************************************************************/

int eof( int handle )         /* determine if at EOF */
{
    off_t   current_posn, file_len;

    file_len = filelength( handle );
    if( file_len == -1L )
        return( -1 );
    current_posn = tell( handle );
    if( current_posn == -1L )
        return( -1 );
    if( current_posn == file_len )
        return( 1 );
    return( 0 );
}

/****************************************************************************
*
* Description:  Implementation of _cmdname().
*
****************************************************************************/

/* NOTE: This file isn't used for QNX. It's got its own version. */

#ifdef __APPLE__

#include <mach-o/dyld.h>

/* No procfs on Darwin, have to use special API */ 

char *_cmdname( char *name )
{
    uint32_t    len = 4096;

    _NSGetExecutablePath( name, &len );
    return( name );
}

#elif defined __UNIX__

char *_cmdname( char *name )
{
    int save_errno = errno;
    int result = readlink( "/proc/self/exe", name, PATH_MAX );
    if( result == -1 ) {
        /* try another way for BSD */
        result = readlink( "/proc/curproc/file", name, PATH_MAX );
    }
    if( result == -1 ) {
        char    path[64];

        /* try yet another way for Solaris */
        sprintf( path, "/proc/%d/path/a.out", getpid() );
        result = readlink( path, name, PATH_MAX );
    }
    errno = save_errno;

    /* fall back to argv[0] if readlink doesn't work */
    if( result == -1 || result == PATH_MAX )
        return( strcpy( name, _argv[0] ) );

    /* readlink does not add a NUL so we need to do it ourselves */
    name[result] = '\0';
    return( name );
}

#elif defined __NT__

char *_cmdname( char *name )
{
    char    name_buf[1024];

    /* Might perhaps use _pgmptr instead. */
    GetModuleFileName( NULL, name_buf, sizeof( name_buf ) );
    return( strcpy( name, name_buf ) );
}

#else

char *_cmdname( char *name )
{
    return( strcpy( name, _argv[0] ) );
}

#endif

#ifdef __UNIX__

/****************************************************************************
*
* Description:  Implementation of getcmd() and _bgetcmd() for Unix.
*
****************************************************************************/

int (_bgetcmd)( char *buffer, int len )
{
    int     total;
    int     i;
    char    *word;
    char    *p     = NULL;
    char    **argv = &_argv[1];

    --len; // reserve space for NULL byte

    if( buffer && (len > 0) ) {
        p  = buffer;
        *p = '\0';
    }

    /* create approximation of original command line */
    for( word = *argv++, i = 0, total = 0; word; word = *argv++ ) {
        i      = strlen( word );
        total += i;

        if( p ) {
            if( i >= len ) {
                strncpy( p, word, len );
                p[len] = '\0';
                p      = NULL;
                len    = 0;
            } else {
                strcpy( p, word );
                p   += i;
                len -= i;
            }
        }

        /* account for at least one space separating arguments */
        if( *argv ) {
            if( p ) {
                *p++ = ' ';
                --len;
            }
            ++total;
        }
    }

    return( total );
}
#endif

#ifdef _MSC_VER

static char *OS_GET_CMD_LINE( void )
{
    char    *cmd = GetCommandLine();

    if( *cmd == '"' ) {
        cmd++;
        while( *cmd && *cmd != '"' ) {
            cmd++;
        }
        if( *cmd ) cmd++;
    } else {
        while( *cmd && *cmd != ' ' && *cmd != '\t' ) {
            ++cmd;
        }
    }
    return cmd;
}

int _bgetcmd( char *buffer, int len )
{
    int         cmdlen;
    char        *cmd;
    char        *tmp;

    if( buffer && (len > 0) )
        *buffer = '\0';

    cmd = OS_GET_CMD_LINE();
    if( !cmd )
        return( 0 );

    while( *cmd == ' ' || *cmd == '\t' )
        ++cmd;

    for( cmdlen = 0, tmp = cmd; *tmp; ++tmp, ++cmdlen )
        ;

    if( !buffer || (len <= 0) )
        return( cmdlen );

    len--;
    len = (len < cmdlen) ? len : cmdlen;

    while( len ) {
        *buffer++ = *cmd++;
        --len;
    }
    buffer[len] = '\0';

    return( cmdlen );
} /* _bgetcmd() */

#endif

char *(getcmd)( char *buffer )
{
    _bgetcmd( buffer, INT_MAX );
    return( buffer );
}

/****************************************************************************
*
* Description:  This function searches for the specified file in the
*               1) current directory or, failing that,
*               2) the paths listed in the specified environment variable
*               until it finds the first occurrence of the file.
*
****************************************************************************/

#if defined(__UNIX__)
        #define PATH_SEPARATOR '/'
        #define LIST_SEPARATOR ':'
#else
        #define PATH_SEPARATOR '\\'
        #define LIST_SEPARATOR ';'
#endif

void _searchenv( const char *name, const char *env_var, char *buffer )
{
    char        *p, *p2;
    int         prev_errno;
    size_t      len;

    prev_errno = errno;
    if( access( name, F_OK ) == 0 ) {
        p = buffer;                                 /* JBS 90/3/30 */
        len = 0;                                    /* JBS 04/1/06 */
        for( ;; ) {
            if( name[0] == PATH_SEPARATOR ) break;
            if( name[0] == '.' ) break;
#ifndef __UNIX__
            if( name[0] == '/' ) break;
            if( (name[0] != '\0') && (name[1] == ':') ) break;
#endif
            if( !getcwd( buffer, _MAX_PATH ) ) {
                buffer[0] = '\0';
                return;
            }
            len = strlen( buffer );
            p = &buffer[ len ];
            if( p[-1] != PATH_SEPARATOR ) {
                if( len < (_MAX_PATH - 1) ) {
                    *p++ = PATH_SEPARATOR;
                    len++;
                }
            }
            break;
        }
        *p = '\0';
        strncat( p, name, (_MAX_PATH - 1) - len );
        return;
    }
    p = getenv( env_var );
    if( p != NULL ) {
        for( ;; ) {
            if( *p == '\0' ) break;
            p2 = buffer;
            len = 0;                                /* JBS 04/1/06 */
            while( *p ) {
                if( *p == LIST_SEPARATOR ) break;
                if( *p != '"' ) {
                    if( len < (_MAX_PATH-1) ) {
                        *p2++ = *p; /* JBS 00/9/29 */
                        len++;
                    }
                }
                p++;
            }
            /* check for zero-length prefix which represents CWD */
            if( p2 != buffer ) {                    /* JBS 90/3/30 */
                if( p2[-1] != PATH_SEPARATOR
#ifndef __UNIX__
                    &&  p2[-1] != '/'
                    &&  p2[-1] != ':'
#endif
                    ) {
                    if( len < (_MAX_PATH - 1) ) {
                        *p2++ = PATH_SEPARATOR;
                        len++;
                    }
                }
                *p2 = '\0';
                len += strlen( name );/* JBS 04/12/23 */
                if( len < _MAX_PATH ) {
                    strcat( p2, name );
                    /* check to see if file exists */
                    if( access( buffer, 0 ) == 0 ) {
                        __set_errno( prev_errno );
                        return;
                    }
                }
            }
            if( *p == '\0' ) break;
            ++p;
        }
    }
    buffer[0] = '\0';
}

/****************************************************************************
*
* Description:  Determine resource language from system environment.
*
****************************************************************************/

res_language_enumeration _WResLanguage(void)
{
    return( RLE_ENGLISH );
}

#if defined( __GLIBC__ ) || defined( _MSC_VER )
/****************************************************************************
*
* Description:  Implementation of BSD style strlcpy().
*
****************************************************************************/

size_t strlcpy( char *dst, const char *src, size_t len )
{
    const char     *s;
    size_t              count;

    count = len;
    if( len ) {
        --len;                  // leave space for terminating null
        for( ; len; --len ) {
            if( *src == '\0' ) {
                break;
            }
            *dst++ = *src++;
        }
        *dst = '\0';            // terminate 'dst'
    } else {
        ++count;                // account for not decrementing 'len'
    }

    if( !len ) {                // source string was truncated
        s = src;
        while( *s != '\0' ) {
            ++s;
        }
        count += s - src;       // find out how long 'src' really is
    }
    return( count - len - 1 );  // final null doesn't count
}

/****************************************************************************
*
* Description:  Implementation of BSD style strlcat().
*
****************************************************************************/

size_t strlcat( char *dst, const char *t, size_t n )
{
    char   *s;
    size_t      len;

    s = dst;
    // Find end of string in destination buffer but don't overrun
    for( len = n; len; --len ) {
        if( *s == '\0' ) break;
        ++s;
    }
    // If no null char was found in dst, the buffer is messed up; don't
    // touch it
    if( *s == '\0' ) {
        --len;      // Decrement len to leave space for terminating null
        while( len != 0 ) {
            *s = *t;
            if( *s == '\0' ) {
                return( n - len - 1 );
            }
            ++s;
            ++t;
            --len;
        }
        // Buffer not large enough. Terminate and figure out desired length
        *s = '\0';
        while( *t++ != '\0' )
            ++n;
        --n;
    }
    return( n );
}
#endif

#endif

#if defined( __NT__ ) && defined( _MSC_VER )

/* Microsoft does not have the super convenient
 * opendir()/readdir()/closedir().
 */
#define SEEK_ATTRIB (~_A_VOLID)

#define FIND_FIRST              FindFirstFileA
#define FIND_NEXT               FindNextFileA
#define CHECK_FIND_NEXT_ATTR    __NTFindNextFileWithAttr
#define GET_DIR_INFO            __GetNTDirInfo

#define _DIR_ISFIRST            0
#define _DIR_NOTFIRST           1
#define _DIR_INVALID            2
#define _DIR_CLOSED             3

/* These are from ntex.h */
#define HANDLE_OF(dirp) ( *( HANDLE * )( &(((char *)(dirp))[0]) ) )
#define ATTR_OF(dirp)  ( *( DWORD * )( &(((char *)(dirp))[4]) ) )

/* From dosret.c */

static int __set_errno_dos( unsigned int err )
{
    __set_errno( EINVAL );  // Fake it
    return( -1 );
}

static int __set_errno_nt( void )
{
    return( __set_errno_dos( GetLastError() ) );
}

static int __set_errno_dos_reterr( unsigned int err )
{
    __set_errno_dos( err );
    return( err );
}

static int __set_errno_nt_reterr( void )
{
    return( __set_errno_dos_reterr( GetLastError() ) );
}

#if 1

/* NB: It might make sense to divide with rounding, but we want
 * to match Microsoft's CRT behavior.
 */
time_t  filetime_to_timet( FILETIME const *ft )
{
    ULARGE_INTEGER  ull;

    ull.LowPart  = ft->dwLowDateTime;
    ull.HighPart = ft->dwHighDateTime;
    return( (ull.QuadPart /*+ 5000000*/) / 10000000ULL - 11644473600ULL );
}

enum {
    TIME_SEC_B  = 0,
    TIME_SEC_F  = 0x001f,
    TIME_MIN_B  = 5,
    TIME_MIN_F  = 0x07e0,
    TIME_HOUR_B = 11,
    TIME_HOUR_F = 0xf800
};

enum {
    DATE_DAY_B  = 0,
    DATE_DAY_F  = 0x001f,
    DATE_MON_B  = 5,
    DATE_MON_F  = 0x01e0,
    DATE_YEAR_B = 9,
    DATE_YEAR_F = 0xfe00
};

/*
 * NB: Autodependency information in OMF object files is stored using DOS timestamps.
 * However, the DosDateTimeToFileTime API incorrectly handles timestamps taken when
 * the daylight saving state was different from the current daylight saving state,
 * and the conversion from FILETIME isn't the same as going through time_t first.
 *  These functions should match the behavior of Microsoft's CRT as much as possible,
 * otherwise wmake believes that timestamps in object files do not match the
 * timestamps of files on disk and keeps rebuilding everything.
 *  Therefore especially the __MakeDOSDT() function is *not* the same as the one
 * in the Watcom run-time.
 */

/* Based on autodept.c. */
static void __FromDOSDT( unsigned short date, unsigned short time, FILETIME *NT_stamp )
/*************************************************************************************/
{
#if 0
    struct tm   tmbuf;
    time_t      t_utc;

    tmbuf.tm_year = ( ( date & DATE_YEAR_F ) >> DATE_YEAR_B ) + 80;
    tmbuf.tm_mon  = ( ( date & DATE_MON_F ) >> DATE_MON_B ) - 1;
    tmbuf.tm_mday = ( date & DATE_DAY_F ) >> DATE_DAY_B;

    tmbuf.tm_hour = ( time & TIME_HOUR_F ) >> TIME_HOUR_B;
    tmbuf.tm_min  = ( time & TIME_MIN_F ) >> TIME_MIN_B;
    tmbuf.tm_sec  = ( ( time & TIME_SEC_F ) >> TIME_SEC_B ) * 2;

    tmbuf.tm_isdst= -1;

    t_utc = mktime( &tmbuf ) );
    SystemTimeToFileTime( &st_utc, NT_stamp );
#else
    FILETIME    local_ft;
    SYSTEMTIME  st_utc, st_local;

    DosDateTimeToFileTime( date, time, &local_ft );
    FileTimeToSystemTime( &local_ft, &st_local );
    TzSpecificLocalTimeToSystemTime( NULL, &st_local, &st_utc );
    SystemTimeToFileTime( &st_utc, NT_stamp );
#endif
}

/* Based on autodept.c. */
static void __MakeDOSDT( FILETIME *NT_stamp, unsigned short *date, unsigned short *time )
/***************************************************************************************/
{
    time_t          t_utc;
    struct tm       *ltime;

    t_utc = filetime_to_timet( NT_stamp );
    ltime = localtime( &t_utc );
    *date = (( ltime->tm_year - 80 ) << DATE_YEAR_B )
             | (( ltime->tm_mon + 1 ) << DATE_MON_B )
             | (( ltime->tm_mday ) << DATE_DAY_B );
    *time = (( ltime->tm_hour ) << TIME_HOUR_B )
             | (( ltime->tm_min ) << TIME_MIN_B )
             | (( ltime->tm_sec / 2 ) << TIME_SEC_B );
    return;
}

#else

/* From ntdirinf.c */

static void __FromDOSDT( unsigned short d, unsigned short t, FILETIME *NT_stamp )
{
    FILETIME local_ft;

    DosDateTimeToFileTime( d, t, &local_ft );
#if 0
    LocalFileTimeToFileTime( &local_ft, NT_stamp );
#else
    SYSTEMTIME  st_utc, st_local;

    FileTimeToSystemTime( &local_ft, &st_local );
    TzSpecificLocalTimeToSystemTime( NULL, &st_local, &st_uts );
    SystemTimeToFileTime( &st_utc, NT_stamp );
#endif
}

static void __MakeDOSDT( FILETIME *NT_stamp, unsigned short *d, unsigned short *t )
{
    FILETIME local_ft;

#if 0
    FileTimeToLocalFileTime( NT_stamp, &local_ft );
#else
    /* The FileTimeToLocalTime API does not take daylight saving into
     * account. It will incorrectly convert timestamps taken when the DST
     * setting was different from the current DST setting.
     * The SystemTimeToTzSpecificLocalTime API takes DST into account
     * correctly, and generates the proper local-time timestamp.
     */
    SYSTEMTIME  st_utc, st_local;

    FileTimeToSystemTime( NT_stamp, &st_utc );
    SystemTimeToTzSpecificLocalTime( NULL, &st_utc, &st_local );
    SystemTimeToFileTime( &st_local, &local_ft );
#endif
    FileTimeToDosDateTime( &local_ft, d, t );
}

#endif

/* From findwnt.c */

static void __GetNTDirInfo(DIR *dirp, LPWIN32_FIND_DATA ffb )
{
    __MakeDOSDT( &ffb->ftLastWriteTime, &dirp->d_date, &dirp->d_time );
    dirp->d_attr = ffb->dwFileAttributes;
    dirp->d_size = ffb->nFileSizeLow;
    strncpy( dirp->d_name, ffb->cFileName, NAME_MAX );
    dirp->d_name[NAME_MAX] = 0;
}

static BOOL __NTFindNextFileWithAttr( HANDLE h, DWORD attr, LPWIN32_FIND_DATA ffb )
{
    for(;;) {
        if( ffb->dwFileAttributes == 0 ) {
            // Win95 seems to return 0 for the attributes sometimes?
            // In that case, treat as a normal file
            ffb->dwFileAttributes = FILE_ATTRIBUTE_NORMAL;
        }
        // JBS 07-jun-99
        if( ((attr & _A_HIDDEN) == 0 ) &&
            (ffb->dwFileAttributes & FILE_ATTRIBUTE_HIDDEN) ) goto skip_file;
        if( ((attr & _A_SYSTEM) == 0 ) &&
            (ffb->dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) ) goto skip_file;
        if( ((attr & _A_SUBDIR) == 0 ) &&
            (ffb->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) ) goto skip_file;
            return ( TRUE );
        skip_file:
        if( !FindNextFileA( h, ffb ) )  return( FALSE );
    }
}

/* From dirwnt.c */

static int is_directory( const char *name )
/*****************************************/
{
    unsigned        curr_ch;
    unsigned        prev_ch;

    curr_ch = '\0';
    for(;;) {
        prev_ch = curr_ch;
        curr_ch = *name;
        if( curr_ch == '\0' )
            break;
        if( prev_ch == '*' )
            break;
        if( prev_ch == '?' )
            break;
        name = _mbsinc( name );
    }
    if( curr_ch == '\0' ) {
        if( prev_ch == '\\' || prev_ch == '/' || prev_ch == '.' ){
            return( 1 );
        }
    }
    return( 0 );
}

static BOOL __find_close( DIR *dirp )
/***********************************/
{
    if( HANDLE_OF( dirp ) )
        return( FindClose( HANDLE_OF( dirp ) ) );
    return( TRUE );
}


DIR *__opendir( const char *dirname, unsigned attr, DIR *dirp )
/*************************************************************/
{
    WIN32_FIND_DATA     ffb;
    HANDLE              h;

    __find_close( dirp );
    h = FIND_FIRST( dirname, &ffb );
    if( h == (HANDLE)-1 ) {
        __set_errno_nt();
        return( NULL );
    }
    if( !CHECK_FIND_NEXT_ATTR( h, attr, &ffb ) ) {
        __set_errno_dos( ERROR_FILE_NOT_FOUND );
        return( NULL );
    }
    HANDLE_OF( dirp ) = h;
    ATTR_OF( dirp ) = attr;
    GET_DIR_INFO( dirp, &ffb );
    dirp->d_first = _DIR_ISFIRST;
    return( dirp );
}

DIR *_opendir( const char *dirname, unsigned attr, DIR *dirp )
/************************************************************/
{

    DIR             tmp;
    int             i;
    char            pathname[MAX_PATH+6];
    const char      *p;
    unsigned        curr_ch;
    unsigned        prev_ch;
    int             flag_opendir = ( dirp == NULL );

    HANDLE_OF( &tmp ) = 0;
    tmp.d_attr = _A_SUBDIR;               /* assume sub-directory */
    if( !is_directory( dirname ) ) {
        if( __opendir( dirname, attr, &tmp ) == NULL ) {
            return( NULL );
        }
    }
    if( tmp.d_attr & _A_SUBDIR ) {
        prev_ch = '\0';
        p = dirname;
        for( i = 0; i < MAX_PATH; i++ ) {
            pathname[i] = *p;
            curr_ch = _mbsnextc( p );
            if( curr_ch > 256 ) {
                ++i;
                ++p;
                pathname[i] = *p;     /* copy second byte */
            }
            if( curr_ch == '\0' ) {
                if( i != 0  &&  prev_ch != '\\' && prev_ch != '/' ){
                    pathname[i++] = '\\';
                }
                strcpy( &pathname[i], "*.*" );
                if( __opendir( pathname, attr, &tmp ) == NULL ) {
                    return( NULL );
                }
                break;
            }
            if( curr_ch == '*' )
                break;
            if( curr_ch == '?' )
                break;
            ++p;
            prev_ch = curr_ch;
        }
    }
    if( flag_opendir ) {
        dirp = malloc( sizeof( DIR ) );
        if( dirp == NULL ) {
            __find_close( &tmp );
            __set_errno_dos( ERROR_NOT_ENOUGH_MEMORY );
            return( NULL );
        }
        tmp.d_openpath = strdup( dirname );
    } else {
        __find_close( dirp );
        tmp.d_openpath = dirp->d_openpath;
    }
    *dirp = tmp;
    return( dirp );
}

DIR *opendir( const char *dirname )
/*********************************/
{
    return( _opendir( dirname, SEEK_ATTRIB, NULL ) );
}

DIR *readdir( DIR *dirp )
/***********************/
{
    WIN32_FIND_DATA     ffd;
    DWORD               err;

    if( dirp == NULL || dirp->d_first >= _DIR_INVALID )
        return( NULL );
    if( dirp->d_first == _DIR_ISFIRST ) {
        dirp->d_first = _DIR_NOTFIRST;
    } else {
        if( !FIND_NEXT( HANDLE_OF( dirp ), &ffd ) ) {
            err = GetLastError();
            if( err != ERROR_NO_MORE_FILES ) {
                __set_errno_dos( err );
            }
            return( NULL );
        }
        if( !CHECK_FIND_NEXT_ATTR( HANDLE_OF( dirp ), ATTR_OF( dirp ), &ffd ) ) {
            __set_errno_dos( ERROR_NO_MORE_FILES );
            return( NULL );
        }
        GET_DIR_INFO( dirp, &ffd );
    }
    return( dirp );

}

int closedir( DIR *dirp )
/***********************/
{

    if( dirp == NULL || dirp->d_first == _DIR_CLOSED ) {
        return( __set_errno_dos( ERROR_INVALID_HANDLE ) );
    }
    if( __find_close( dirp ) == FALSE ) {
        return( __set_errno_nt() );
    }
    dirp->d_first = _DIR_CLOSED;
    if( dirp->d_openpath != NULL )
        free( dirp->d_openpath );
    free( dirp );
    return( 0 );
}

void rewinddir( DIR *dirp )
/*************************/
{
    if( dirp == NULL || dirp->d_openpath == NULL )
        return;
    if( _opendir( dirp->d_openpath, SEEK_ATTRIB, dirp ) == NULL ) {
        dirp->d_first = _DIR_INVALID;    /* so reads won't work any more */
    }
}

/* Partially inspired by setenv.c */

static char setenv_buf[4096];

_WCRTLINK int setenv( const char *name, const char *newvalue, int overwrite )
{
    int                 rc;

    /*** Ensure variable is deleted if newvalue == "" ***/
    if( (newvalue != NULL) && (*newvalue == '\0') ) {
        if( overwrite || (getenv( name ) == NULL) ) {
            newvalue = NULL;
        }
    }

    /*** Must use putenv() for runtime-supplied getenv() to work. */
    if( overwrite || getenv( name ) == NULL ) {
        snprintf( setenv_buf, sizeof( setenv_buf ), "%s=%s", name, newvalue ? newvalue : "" );
        return( putenv( setenv_buf ) );
    }

    return( 0 );
}

/* From gdrvewnt.c */

void _dos_getdrive( unsigned *drive )
{
    char        buff[MAX_PATH];

    GetCurrentDirectory( sizeof( buff ), buff );
    *drive = tolower( buff[0] ) - 'a'+1;
}

/* From sdrvewnt.c */

void _dos_setdrive( unsigned drivenum, unsigned *drives )
{
    char        dir[4];

    dir[0] = drivenum + 'a' - 1;
    dir[1] = ':';
    dir[2] = '.';
    dir[3] = 0;

    SetCurrentDirectory( dir );
    *drives = -1;
}

/* From gfattwnt.c */

unsigned _dos_getfileattr( const char *path, unsigned *attribute )
{
    HANDLE              h;
    WIN32_FIND_DATA     ffb;

    h = FindFirstFile( (LPTSTR)path, &ffb );
    if( h == (HANDLE)-1 ) {
        return( __set_errno_nt_reterr() );
    }
    *attribute = ffb.dwFileAttributes;
    FindClose( h );
    return( 0 );
}

/* From sfattwnt.c */

unsigned _dos_setfileattr( const char *path, unsigned attribute )
{
    if( attribute == 0 )
        attribute = FILE_ATTRIBUTE_NORMAL;

    if( !SetFileAttributes( (LPTSTR) path, attribute ) ) {
        return( __set_errno_nt_reterr() );
    }
    return( 0 );
}

/* From sftimwnt.c */

unsigned _dos_setftime( int hid, unsigned date, unsigned time )
{
    HANDLE      h;
    FILETIME    ctime, atime, wtime;

    h = (HANDLE)_get_osfhandle( hid );
    if( GetFileTime( h, &ctime, &atime, &wtime ) ) {
        __FromDOSDT( date, time, &wtime );
        if( SetFileTime( h, &ctime, &wtime, &wtime ) ) {
            return( 0 );
        }
    }
    return( __set_errno_nt_reterr() );
}

/* From gftimwnt.c */

unsigned _dos_getftime( int hid, unsigned *date, unsigned *time )
{
    FILETIME        ctime, atime, wtime;
    unsigned short  d, t;

    if( GetFileTime( (HANDLE)_get_osfhandle( hid ), &ctime, &atime, &wtime ) ) {
        __MakeDOSDT( &wtime, &d, &t );
        *date = d;
        *time = t;
        return( 0 );
    }
    return( __set_errno_nt_reterr() );
}

/* From fnmatch.c */

#include "../ch/fnmatch.h"

/* Implementation note: On non-UNIX systems, backslashes in the string
 * (but not in the pattern) are considered to be path separators and
 * identical to forward slashes when FNM_PATHNAME is set.
 */
#define IS_PATH_SEP(c)   (c == '/' || c == '\\')

static char fnm_icase( int ch, int flags )
{
    if( flags & FNM_IGNORECASE ) {
        return( tolower( ch ) );
    } else {
        return( ch );
    }
}

/* Maximum length of character class name.
 * The longest is currently 'xdigit' (6 chars).
 */
#define CCL_NAME_MAX    8

/* Note: Using wctype()/iswctype() may seem odd, but that way we can avoid
 * hardcoded character class lists.
 */
static int fnm_sub_bracket( const char *p, int c )
{
    const char      *s = p;
    char            sname[CCL_NAME_MAX + 1];
    int             i;
    int             type;

    switch( *++p ) {
    case ':':
        ++p;
        for( i = 0; i < CCL_NAME_MAX; i++ ) {
            if( !isalpha(*p ) )
                break;
            sname[i] = *p++;
        }
        sname[i] = '\0';
        if( *p++ != ':' )
            return( 0 );
        if( *p++ != ']' )
            return( 0 );
        type = wctype( sname );
        if( type ) {
            int     rc;

            rc = p - s;
            return( iswctype( c, type ) ? rc : -rc );
        }
        return( 0 );
    case '=':
        return( 0 );
    case '.':
        return( 0 );
    default:
        return( 0 );
    }
}


static const char *fnm_cclass_match( const char *patt, int c )
{
    int	        ok = 0;
    int	        lc = 0;
    int	        state = 0;
    int         invert = 0;
    int	        sb;

    /* Meaning of '^' is unspecified in POSIX - consider it equal to '!' */
    if( *patt == '!' || *patt == '^' ) {
        invert = 1;
        ++patt;
    }
    while( *patt ) {
    	if( *patt == ']' )
    	    return( ok ^ invert ? patt + 1 : NULL );

        if( *patt == '[' ) {
             sb = fnm_sub_bracket( patt, c );
             if( sb < 0 ) {
                 patt -= sb;
                 ok = 0;
                 continue;
             } else if( sb > 0 ) {
                 patt += sb;
                 ok = 1;
                 continue;
             }
        }

        switch( state ) {
        case 0:
    	    if( *patt == '\\' )
                ++patt;
    	    if( *patt == c )
                ok = 1;
    	    lc = (int)*patt++;
    	    state = 1;
    	    break;
    	case 1:
    	    if( state = (*patt == '-') ? 2 : 0 )
                ++patt;
    	    break;
    	case 2:
    	    if( *patt == '\\' )
                ++patt;
            if( lc <= c && c <= *patt )
                ok = 1;
    	    ++patt;
    	    state = 0;
    	    break;
    	default:
    	    return( NULL );
    	}
    }
    return( NULL );
}


int fnmatch( const char *patt, const char *s, int flags )
/*******************************************************/
{
    char        c, cl;
    const char  *start = s;

    while( 1 ) {
        c = fnm_icase( *patt++, flags );
    	switch( c ) {
        case '\0':
            if( flags & FNM_LEADING_DIR && IS_PATH_SEP( *s ) )
                return( 0 );
            return( *s ? FNM_NOMATCH : 0 );
    	case '?':
            if( flags & FNM_PATHNAME && IS_PATH_SEP( *s ) )
                return( FNM_NOMATCH );
            if( flags & FNM_PERIOD && *s == '.' && s == start )
                return( FNM_NOMATCH );
            ++s;
    	    break;
        case '[':
            if( flags & FNM_PATHNAME && IS_PATH_SEP( *s ) )
                return( FNM_NOMATCH );
            if( flags & FNM_PERIOD && *s == '.' && s == start )
                return( FNM_NOMATCH );
            patt = fnm_cclass_match( patt, *s );
    	    if( patt == NULL )
                return( FNM_NOMATCH );
    	    ++s;
    	    break;
        case '*':
            if( *s == '\0' )
                return( 0 );
            if( flags & FNM_PATHNAME && ( *patt == '/' ) ) {
                while( *s && !IS_PATH_SEP( *s ) )
                    ++s;
                break;
            }
            if( flags & FNM_PERIOD && *s == '.' && s == start )
                return( FNM_NOMATCH );
            if( *patt == '\0' ) {
                /* Shortcut - don't examine every remaining character. */
                if( flags & FNM_PATHNAME ) {
                    if( flags & FNM_LEADING_DIR || !strchr( s, '/' ) )
                        return( 0 );
                    else
                        return( FNM_NOMATCH );
                } else {
                    return( 0 );
                }
            }
            while( (cl = fnm_icase( *s, flags )) != '\0' ) {
                if( !fnmatch( patt, s, flags & ~FNM_PERIOD ) )
                    return( 0 );
                if( flags & FNM_PATHNAME && IS_PATH_SEP( cl ) ) {
                    start = s + 1;
                    break;
                }
                ++s;
            }
    	    return( FNM_NOMATCH );
        case '\\':
            if( !( flags & FNM_NOESCAPE ) ) {
                c = fnm_icase( *patt++, flags );
            }
            /* Fall through */
        default:
            if( IS_PATH_SEP( *s ) )
                start = s + 1;
            cl = fnm_icase( *s++, flags );
            if( flags & FNM_PATHNAME && cl == '\\' )
                cl = '/';
    	    if( c != cl )
                return( FNM_NOMATCH );
    	}
    }
}

/* From getopt.c */

char      *optarg;            // pointer to option argument
int       optind = 1;         // current argv[] index
int       optopt;             // currently processed chracter
int       opterr = 1;         // error output control flag

char                __altoptchar = '/'; // alternate option character
char                __optchar;          // matched option char ('-' or altoptchar)

static int          opt_offset = 0;     // position in currently parsed argument

// Error messages suggested by Single UNIX Specification
#define NO_ARG_MSG      "%s: option requires an argument -- %c\n"
#define BAD_OPT_MSG     "%s: illegal option -- %c\n"

int getopt( int argc, char * const argv[], const char *optstring )
/****************************************************************/
{
    char        *ptr;
    char        *curr_arg;

    optarg = NULL;
    curr_arg = argv[optind];
    if( curr_arg == NULL ) {
        return( -1 );
    }
    for( ;; ) {
        optopt = curr_arg[opt_offset];
        if( isspace( optopt ) ) {
            opt_offset++;
            continue;
        }
        break;
    }
    if( opt_offset > 1 || optopt == '-' || optopt == __altoptchar ) {
        if( opt_offset > 1 ) {
            optopt = curr_arg[opt_offset];
            if( optopt == '-' || optopt == __altoptchar ) {
                __optchar = optopt;
                opt_offset++;
                optopt = curr_arg[opt_offset];
            }
        } else {
            __optchar = optopt;
            opt_offset++;
            optopt = curr_arg[opt_offset];
        }
        if( optopt == '\0' ) {  // option char by itself should be
            return( -1 );       // left alone
        }
        if( optopt == '-' && curr_arg[opt_offset + 1] == '\0' ) {
            opt_offset = 0;
            ++optind;
            return( -1 );   // "--" POSIX end of options delimiter
        }
        ptr = strchr( optstring, optopt );
        if( ptr == NULL ) {
            if( opterr && *optstring != ':' ) {
                fprintf( stderr, BAD_OPT_MSG, argv[0], optopt );
            }
            return( '?' );  // unrecognized option
        }
        if( *(ptr + 1) == ':' ) {   // check if option requires argument
            if( curr_arg[opt_offset + 1] == '\0' ) {
                if( argv[optind + 1] == NULL ) {
                    if( *optstring == ':' ) {
                        return( ':' );
                    } else {
                        if( opterr ) {
                            fprintf( stderr, NO_ARG_MSG, argv[0], optopt );
                        }
                        return( '?' );
                    }
                }
                optarg = argv[optind + 1];
                ++optind;
            } else {
                optarg = &curr_arg[opt_offset + 1];
            }
            opt_offset = 0;
            ++optind;
        } else {
            opt_offset++;
            if( curr_arg[opt_offset] == '\0' ) {    // last char in argv element
                opt_offset = 0;
                ++optind;
            }
        }
        return( optopt );   // return recognized option char
    } else {
        return( -1 );       // no more options
    }
}

/* From mkstemp.c */
static int is_valid_template( char *template, char **xs )
{
    int                 len;
    char                *p;

    /*** Ensure the last 6 characters form the string "XXXXXX" ***/
    len = strlen( template );
    if( len < 6 ) {
        return( 0 );        /* need room for six exes */
    }
    p = template + len - 6;
    if( strcmp( p, "XXXXXX" ) ) {
        return( 0 );
    }
    *xs = p;

    return( 1 );
}


int mkstemp( char *template )
{
    char                letter;
    unsigned            pid;
    char                *xs;
    int                 fh;

    /*** Ensure the template is valid ***/
    if( !is_valid_template( template, &xs ) ) {
        return( -1 );
    }

    /*** Get the process/thread ID ***/
    pid = getpid();
    pid %= 100000;      /* first few digits could be repeated */

    /*** Try to build a unique filename ***/
    for( letter = 'a'; letter <= 'z'; letter++ ) {
        snprintf( xs, strlen( xs ) + 1, "%c%05u", letter, pid );
        if( access( template, F_OK ) != 0 ) {
            fh = open( template,
                       O_RDWR | O_CREAT | O_TRUNC | O_EXCL | O_BINARY,
                       S_IRUSR | S_IWUSR );
            if( fh != -1 ) {
                return( fh );       /* file successfully created */
            }
            /* EEXIST may occur in case of a race condition or if we simply
             * created that temp file earlier, and we'll try again. If however
             * the creation failed for some other reason, it will almost
             * certainly fail again no matter how many times we try. So don't.
             */
            if( errno != EEXIST ) {
                return( -1 );
            }
        }
    }
    return( -1 );
}

#endif
