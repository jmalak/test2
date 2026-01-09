# Examples Builder Control file
# =============================

set PROJDIR=<CWD>
set PROJNAME=examples

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
# NB: Not using conditional copy (CCCMD) because all these files
# are expected to exist in the source tree.
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrt386.asm            <RELROOT>/src/startup/386/cstrt386.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrtw32.asm            <RELROOT>/src/startup/386/cstrtw32.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrtwnt.asm            <RELROOT>/src/startup/386/cstrtwnt.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrtx32.asm            <RELROOT>/src/startup/386/cstrtx32.asm
    <CPCMD> <OWROOT>/src/clib/startup/c/cmain386.c              <RELROOT>/src/startup/386/cmain386.c
    <CPCMD> <OWROOT>/src/clib/startup/c/wildargv.c              <RELROOT>/src/startup/wildargv.c
    <CPCMD> <OWROOT>/src/clib/h/initarg.h                       <RELROOT>/src/startup/initarg.h
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrt086.asm            <RELROOT>/src/startup/dos/cstrt086.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/dos16m.asm              <RELROOT>/src/startup/dos/dos16m.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/dllstart.asm            <RELROOT>/src/startup/386/dllstart.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/dstrt386.asm            <RELROOT>/src/startup/386/dstrt386.asm
    <CPCMD> <OWROOT>/src/clib/startup/c/cmain086.c              <RELROOT>/src/startup/dos/cmain086.c
    <CPCMD> <OWROOT>/src/clib/startup/c/cmain086.c              <RELROOT>/src/startup/os2/cmain086.c
    <CPCMD> <OWROOT>/src/clib/startup/c/hpgrw086.c              <RELROOT>/src/startup/dos/hpgrw086.c
    <CPCMD> <OWROOT>/src/clib/startup/c/dmaino16.c              <RELROOT>/src/startup/os2/dmaino16.c
    <CPCMD> <OWROOT>/src/clib/startup/c/libmno16.c              <RELROOT>/src/startup/os2/libmno16.c
    <CPCMD> <OWROOT>/src/clib/startup/c/maino16.c               <RELROOT>/src/startup/os2/maino16.c
    <CPCMD> <OWROOT>/src/clib/startup/c/main2o32.c              <RELROOT>/src/startup/386/main2o32.c
    <CPCMD> <OWROOT>/src/clib/startup/c/libmno32.c              <RELROOT>/src/startup/386/libmno32.c
    <CPCMD> <OWROOT>/src/clib/startup/c/dmaino32.c              <RELROOT>/src/startup/386/dmaino32.c
    <CPCMD> <OWROOT>/src/clib/startup/c/main2wnt.c              <RELROOT>/src/startup/386/main2wnt.c
    <CPCMD> <OWROOT>/src/clib/startup/c/wmainwnt.c              <RELROOT>/src/startup/386/wmainwnt.c
    <CPCMD> <OWROOT>/src/clib/startup/c/lmainwnt.c              <RELROOT>/src/startup/386/lmainwnt.c
    <CPCMD> <OWROOT>/src/clib/startup/c/dmainwnt.c              <RELROOT>/src/startup/386/dmainwnt.c
    <CPCMD> <OWROOT>/src/clib/startup/c/lmn2wnt.c               <RELROOT>/src/startup/386/lmn2wnt.c
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrto16.asm            <RELROOT>/src/startup/os2/cstrto16.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrto32.asm            <RELROOT>/src/startup/386/cstrto32.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/cstrtw16.asm            <RELROOT>/src/startup/win/cstrtw16.asm
    <CPCMD> <OWROOT>/src/clib/startup/a/libentry.asm            <RELROOT>/src/startup/win/libentry.asm
    <CPCMD> <OWROOT>/src/clib/startup/c/8087cw.c                <RELROOT>/src/startup/8087cw.c
    <CPCMD> <OWROOT>/src/lib_misc/h/exitwmsg.h                  <RELROOT>/src/startup/os2/exitwmsg.h
    <CPCMD> <OWROOT>/src/clib/startup/h/initfini.h              <RELROOT>/src/startup/386/initfini.h
    <CPCMD> <OWROOT>/src/clib/startup/h/initfini.h              <RELROOT>/src/startup/os2/initfini.h
    <CPCMD> <OWROOT>/src/watcom/h/wos2.h                        <RELROOT>/src/startup/os2/wos2.h
    <CPCMD> <OWROOT>/src/watcom/h/mdef.inc                      <RELROOT>/src/startup/mdef.inc
    <CPCMD> <OWROOT>/src/watcom/h/xinit.inc                     <RELROOT>/src/startup/xinit.inc
    <CPCMD> <OWROOT>/src/comp_cfg/h/langenv.inc                 <RELROOT>/src/startup/langenv.inc
    <CPCMD> <OWROOT>/src/clib/startup/a/msgrt16.inc             <RELROOT>/src/startup/msgrt16.inc
    <CPCMD> <OWROOT>/src/clib/startup/a/msgrt32.inc             <RELROOT>/src/startup/msgrt32.inc
    <CPCMD> <OWROOT>/src/clib/startup/a/msgcpyrt.inc            <RELROOT>/src/startup/msgcpyrt.inc

    <CPCMD> <OWROOT>/src/examples/misc/*                        <RELROOT>/src/

    <CPCMD> <OWROOT>/src/cpplib/contain/cpp/*                   <RELROOT>/src/cpplib/contain/

    <CPCMD> <OWROOT>/src/examples/clibexam/*                    <RELROOT>/samples/clibexam/
    <CPCMD> <OWROOT>/src/examples/cplbexam/*                    <RELROOT>/samples/cplbexam/

    <CPCMD> <OWROOT>/src/examples/cppexamp/*                    <RELROOT>/samples/cppexamp/
    <CPCMD> <OWROOT>/src/examples/cppexamp/excarea/*            <RELROOT>/samples/cppexamp/excarea/
    <CPCMD> <OWROOT>/src/examples/cppexamp/membfun/*            <RELROOT>/samples/cppexamp/membfun/
    <CPCMD> <OWROOT>/src/examples/cppexamp/rtti/*               <RELROOT>/samples/cppexamp/rtti/

    <CPCMD> <OWROOT>/src/examples/dll/*                         <RELROOT>/samples/dll/
    <CPCMD> <OWROOT>/src/examples/goodies/*                     <RELROOT>/samples/goodies/
    <CPCMD> <OWROOT>/src/examples/os2/*                         <RELROOT>/samples/os2/
    <CPCMD> <OWROOT>/src/examples/os2/dll/*                     <RELROOT>/samples/os2/dll/
    <CPCMD> <OWROOT>/src/examples/os2/pdd/*                     <RELROOT>/samples/os2/pdd/
    <CPCMD> <OWROOT>/src/examples/os2/som/*                     <RELROOT>/samples/os2/som/
    <CPCMD> <OWROOT>/src/examples/os2/som/animals/*             <RELROOT>/samples/os2/som/animals/
    <CPCMD> <OWROOT>/src/examples/os2/som/classes/*             <RELROOT>/samples/os2/som/classes/
    <CPCMD> <OWROOT>/src/examples/os2/som/helloc/*              <RELROOT>/samples/os2/som/helloc/
    <CPCMD> <OWROOT>/src/examples/os2/som/hellocpp/*            <RELROOT>/samples/os2/som/hellocpp/
    <CPCMD> <OWROOT>/src/examples/os2/som/wps/*                 <RELROOT>/samples/os2/som/wps/
    <CPCMD> <OWROOT>/src/examples/win/*                         <RELROOT>/samples/win/
    <CPCMD> <OWROOT>/src/examples/clibexam/kanji/*              <RELROOT>/samples/clibexam/kanji/
    <CPCMD> <OWROOT>/src/examples/clibexam/test/*               <RELROOT>/samples/clibexam/test/
    <CPCMD> <OWROOT>/src/examples/cplbexam/complex/*            <RELROOT>/samples/cplbexam/complex/
    <CPCMD> <OWROOT>/src/examples/cplbexam/contain/*            <RELROOT>/samples/cplbexam/contain/
    <CPCMD> <OWROOT>/src/examples/cplbexam/fstream/*            <RELROOT>/samples/cplbexam/fstream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/ios/*                <RELROOT>/samples/cplbexam/ios/
    <CPCMD> <OWROOT>/src/examples/cplbexam/iostream/*           <RELROOT>/samples/cplbexam/iostream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/string/*             <RELROOT>/samples/cplbexam/string/
    <CPCMD> <OWROOT>/src/examples/cplbexam/strstrea/*           <RELROOT>/samples/cplbexam/strstrea/
    <CPCMD> <OWROOT>/src/examples/cplbexam/complex/friend/*     <RELROOT>/samples/cplbexam/complex/friend/
    <CPCMD> <OWROOT>/src/examples/cplbexam/complex/pubfun/*     <RELROOT>/samples/cplbexam/complex/pubfun/
    <CPCMD> <OWROOT>/src/examples/cplbexam/complex/relfun/*     <RELROOT>/samples/cplbexam/complex/relfun/
    <CPCMD> <OWROOT>/src/examples/cplbexam/complex/relop/*      <RELROOT>/samples/cplbexam/complex/relop/
    <CPCMD> <OWROOT>/src/examples/cplbexam/fstream/fstream/*    <RELROOT>/samples/cplbexam/fstream/fstream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/fstream/ifstream/*   <RELROOT>/samples/cplbexam/fstream/ifstream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/fstream/ofstream/*   <RELROOT>/samples/cplbexam/fstream/ofstream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/iostream/iostream/*  <RELROOT>/samples/cplbexam/iostream/iostream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/iostream/istream/*   <RELROOT>/samples/cplbexam/iostream/istream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/iostream/ostream/*   <RELROOT>/samples/cplbexam/iostream/ostream/
    <CPCMD> <OWROOT>/src/examples/cplbexam/string/friend/*      <RELROOT>/samples/cplbexam/string/friend/
    <CPCMD> <OWROOT>/src/examples/cplbexam/string/pubfun/*      <RELROOT>/samples/cplbexam/string/pubfun/
    <CPCMD> <OWROOT>/src/examples/cplbexam/strstrea/istrstre/*  <RELROOT>/samples/cplbexam/strstrea/istrstre/
    <CPCMD> <OWROOT>/src/examples/cplbexam/strstrea/ostrstre/*  <RELROOT>/samples/cplbexam/strstrea/ostrstre/
    <CPCMD> <OWROOT>/src/examples/cplbexam/strstrea/strstre/*   <RELROOT>/samples/cplbexam/strstrea/strstre/
    <CPCMD> <OWROOT>/src/examples/win/alarm/*                   <RELROOT>/samples/win/alarm/
    <CPCMD> <OWROOT>/src/examples/win/datactl/*                 <RELROOT>/samples/win/datactl/
    <CPCMD> <OWROOT>/src/examples/win/edit/*                    <RELROOT>/samples/win/edit/
    <CPCMD> <OWROOT>/src/examples/win/generic/*                 <RELROOT>/samples/win/generic/
    <CPCMD> <OWROOT>/src/examples/win/helpex/*                  <RELROOT>/samples/win/helpex/
    <CPCMD> <OWROOT>/src/examples/win/iconview/*                <RELROOT>/samples/win/iconview/
    <CPCMD> <OWROOT>/src/examples/win/life/*                    <RELROOT>/samples/win/life/
    <CPCMD> <OWROOT>/src/examples/win/shootgal/*                <RELROOT>/samples/win/shootgal/
    <CPCMD> <OWROOT>/src/examples/win/watzee/*                  <RELROOT>/samples/win/watzee/
    <CPCMD> <OWROOT>/src/examples/win/alarm/win16/*             <RELROOT>/samples/win/alarm/win16/
    <CPCMD> <OWROOT>/src/examples/win/alarm/win32/*             <RELROOT>/samples/win/alarm/win32/
    <CPCMD> <OWROOT>/src/examples/win/alarm/win386/*            <RELROOT>/samples/win/alarm/win386/
    <CPCMD> <OWROOT>/src/examples/win/alarm/winaxp/*            <RELROOT>/samples/win/alarm/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/datactl/win16/*           <RELROOT>/samples/win/datactl/win16/
    <CPCMD> <OWROOT>/src/examples/win/datactl/win32/*           <RELROOT>/samples/win/datactl/win32/
    <CPCMD> <OWROOT>/src/examples/win/datactl/win386/*          <RELROOT>/samples/win/datactl/win386/
    <CPCMD> <OWROOT>/src/examples/win/datactl/winaxp/*          <RELROOT>/samples/win/datactl/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/edit/win16/*              <RELROOT>/samples/win/edit/win16/
    <CPCMD> <OWROOT>/src/examples/win/edit/win32/*              <RELROOT>/samples/win/edit/win32/
    <CPCMD> <OWROOT>/src/examples/win/edit/win386/*             <RELROOT>/samples/win/edit/win386/
    <CPCMD> <OWROOT>/src/examples/win/edit/winaxp/*             <RELROOT>/samples/win/edit/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/generic/win16/*           <RELROOT>/samples/win/generic/win16/
    <CPCMD> <OWROOT>/src/examples/win/generic/win32/*           <RELROOT>/samples/win/generic/win32/
    <CPCMD> <OWROOT>/src/examples/win/generic/win386/*          <RELROOT>/samples/win/generic/win386/
    <CPCMD> <OWROOT>/src/examples/win/generic/winaxp/*          <RELROOT>/samples/win/generic/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/helpex/win16/*            <RELROOT>/samples/win/helpex/win16/
    <CPCMD> <OWROOT>/src/examples/win/helpex/win32/*            <RELROOT>/samples/win/helpex/win32/
    <CPCMD> <OWROOT>/src/examples/win/helpex/win386/*           <RELROOT>/samples/win/helpex/win386/
    <CPCMD> <OWROOT>/src/examples/win/helpex/winaxp/*           <RELROOT>/samples/win/helpex/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/iconview/win16/*          <RELROOT>/samples/win/iconview/win16/
    <CPCMD> <OWROOT>/src/examples/win/iconview/win32/*          <RELROOT>/samples/win/iconview/win32/
    <CPCMD> <OWROOT>/src/examples/win/iconview/win386/*         <RELROOT>/samples/win/iconview/win386/
    <CPCMD> <OWROOT>/src/examples/win/iconview/winaxp/*         <RELROOT>/samples/win/iconview/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/life/win16/*              <RELROOT>/samples/win/life/win16/
    <CPCMD> <OWROOT>/src/examples/win/life/win32/*              <RELROOT>/samples/win/life/win32/
    <CPCMD> <OWROOT>/src/examples/win/life/win386/*             <RELROOT>/samples/win/life/win386/
    <CPCMD> <OWROOT>/src/examples/win/life/winaxp/*             <RELROOT>/samples/win/life/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/shootgal/win16/*          <RELROOT>/samples/win/shootgal/win16/
    <CPCMD> <OWROOT>/src/examples/win/shootgal/win32/*          <RELROOT>/samples/win/shootgal/win32/
    <CPCMD> <OWROOT>/src/examples/win/shootgal/win386/*         <RELROOT>/samples/win/shootgal/win386/
    <CPCMD> <OWROOT>/src/examples/win/shootgal/winaxp/*         <RELROOT>/samples/win/shootgal/winaxp/
    <CPCMD> <OWROOT>/src/examples/win/watzee/win16/*            <RELROOT>/samples/win/watzee/win16/
    <CPCMD> <OWROOT>/src/examples/win/watzee/win32/*            <RELROOT>/samples/win/watzee/win32/
    <CPCMD> <OWROOT>/src/examples/win/watzee/win386/*           <RELROOT>/samples/win/watzee/win386/
    <CPCMD> <OWROOT>/src/examples/win/watzee/winaxp/*           <RELROOT>/samples/win/watzee/winaxp/

    <CPCMD> <OWROOT>/src/examples/directx/c/d3d/*               <RELROOT>/samples/directx/c/d3d/
    <CPCMD> <OWROOT>/src/examples/directx/c/dinput/*            <RELROOT>/samples/directx/c/dinput/
    <CPCMD> <OWROOT>/src/examples/directx/c/dshow/*             <RELROOT>/samples/directx/c/dshow/
    <CPCMD> <OWROOT>/src/examples/directx/c/dsound/*            <RELROOT>/samples/directx/c/dsound/
    <CPCMD> <OWROOT>/src/examples/directx/cpp/d3d/*             <RELROOT>/samples/directx/cpp/d3d/
    <CPCMD> <OWROOT>/src/examples/directx/cpp/dinput/*          <RELROOT>/samples/directx/cpp/dinput/
    <CPCMD> <OWROOT>/src/examples/directx/cpp/dshow/*           <RELROOT>/samples/directx/cpp/dshow/
    <CPCMD> <OWROOT>/src/examples/directx/cpp/dsound/*          <RELROOT>/samples/directx/cpp/dsound/
    <CPCMD> <OWROOT>/src/examples/directx/*                     <RELROOT>/samples/directx/

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
