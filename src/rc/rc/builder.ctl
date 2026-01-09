# Resource Compiler Builder Control file
# ======================================

set PROJDIR=<CWD>
set PROJNAME=wrc

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> <PROJDIR>/*.uni                  <RELROOT>/binw/
    <CPCMD> <PROJDIR>/*.uni                  <RELROOT>/binl/

#    <CPCMD> <PROJDIR>/osi386/wrce.exe        <RELROOT>/binw/wrc.exe
    <CCCMD> <PROJDIR>/dos386/wrce.exe        <RELROOT>/binw/wrc.exe
    <CCCMD> <PROJDIR>/dos386/wrce.sym        <RELROOT>/binw/wrc.sym
    <CCCMD> <PROJDIR>/os2386.dll/wrce.exe     <RELROOT>/binp/wrc.exe
    <CCCMD> <PROJDIR>/os2386.dll/wrce.sym     <RELROOT>/binp/wrc.sym
    <CCCMD> <PROJDIR>/os2386.dll/wrcde.dll   <RELROOT>/binp/dll/wrcd.dll
    <CCCMD> <PROJDIR>/os2386.dll/wrcde.sym   <RELROOT>/binp/dll/wrcd.sym
    <CCCMD> <PROJDIR>/nt386.dll/wrce.exe     <RELROOT>/binnt/wrc.exe
    <CCCMD> <PROJDIR>/nt386.dll/wrce.sym     <RELROOT>/binnt/wrc.sym
    <CCCMD> <PROJDIR>/nt386.dll/wrcde.dll    <RELROOT>/binnt/wrcd.dll
    <CCCMD> <PROJDIR>/nt386.dll/wrcde.sym    <RELROOT>/binnt/wrcd.sym
    <CCCMD> <PROJDIR>/nt386rt.dll/wrcde.dll  <RELROOT>/binnt/rtdll/wrcd.dll
    <CCCMD> <PROJDIR>/nt386rt.dll/wrcde.sym  <RELROOT>/binnt/rtdll/wrcd.sym
    <CCCMD> <PROJDIR>/ntaxp/wrce.exe         <RELROOT>/axpnt/wrc.exe
    <CCCMD> <PROJDIR>/ntaxp/wrce.sym         <RELROOT>/axpnt/wrc.sym
    <CCCMD> <PROJDIR>/linux386/wrce.exe      <RELROOT>/binl/wrc
    <CCCMD> <PROJDIR>/linux386/wrce.sym      <RELROOT>/binl/wrc.sym

[ BLOCK <1> boot ]
#=================
    <CPCMD> <PROJDIR>/<OWOBJDIR>/wrce.exe <OWBINDIR>/wrc<CMDEXT>
    <CPCMD> <PROJDIR>/kanji.uni <OWBINDIR>/
    <CPCMD> <PROJDIR>/<OWOBJDIR>/wrce.exe <RELROOT>/bin/wrc<CMDEXT>
    <CPCMD> <PROJDIR>/kanji.uni <RELROOT>/bin/

[ BLOCK <1> bootclean ]
#======================
    rm -f <OWBINDIR>/wrc<CMDEXT>
    rm -f <OWBINDIR>/kanji.uni

[ BLOCK . . ]
#============
cdsay <PROJDIR>
