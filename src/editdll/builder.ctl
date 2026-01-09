# EditDLL Builder Control file
# ============================

set PROJDIR=<CWD>
set PROJNAME=editdll

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> <2> rel cprel ]
#==========================
    cdsay <PROJDIR>
    <CCCMD> epm/epmlink.dll            <RELROOT>/binp/dll/epmlink.dll
    <CCCMD> epm/epmlink.sym            <RELROOT>/binp/dll/epmlink.sym
    <CCCMD> epm/wedit.lib              <RELROOT>/src/editdll/os2/wedit.lib
    <CCCMD> epm/wedit.dll              <RELROOT>/src/editdll/os2/wedit.dll

    <CCCMD> viw/wini86/weditviw.dll    <RELROOT>/binw/weditviw.dll
    <CCCMD> viw/wini86/weditviw.sym    <RELROOT>/binw/weditviw.sym
    <CCCMD> cw/wini86/weditcw.dll      <RELROOT>/binw/weditcw.dll
    <CCCMD> viw/wini86/wedit.lib       <RELROOT>/src/editdll/win/wedit.lib
    <CCCMD> cw/wini86/wedit.dll        <RELROOT>/src/editdll/win/cw/wedit.dll
    <CCCMD> viw/wini86/wedit.dll       <RELROOT>/src/editdll/win/viw/wedit.dll

    <CCCMD> viw/nt386/weditviw.dll     <RELROOT>/binnt/weditviw.dll
    <CCCMD> viw/nt386/weditviw.sym     <RELROOT>/binnt/weditviw.sym
    <CCCMD> cw/nt386/weditcw.dll       <RELROOT>/binnt/weditcw.dll
    <CCCMD> viw/nt386/wedit.lib        <RELROOT>/src/editdll/nt/wedit.lib
    <CCCMD> cw/nt386/wedit.dll         <RELROOT>/src/editdll/nt/cw/wedit.dll
    <CCCMD> viw/nt386/wedit.dll        <RELROOT>/src/editdll/nt/viw/wedit.dll

    <CCCMD> viw/ntaxp/weditviw.dll     <RELROOT>/axpnt/weditviw.dll
    <CCCMD> viw/ntaxp/weditviw.sym     <RELROOT>/axpnt/weditviw.sym

    <CCCMD> wedit.h                    <RELROOT>/src/editdll/wedit.h
    <CCCMD> wedit.doc                  <RELROOT>/src/editdll/wedit.doc


[ BLOCK . . ]
#============
cdsay <PROJDIR>
