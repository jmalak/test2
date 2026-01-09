# wstub Builder Control file
# ==========================

set PROJDIR=<CWD>
set PROJNAME=wstub

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dosi86/wstub.exe    <RELROOT>/binw/wstub.exe
    <CCCMD> dosi86/wstubq.exe   <RELROOT>/binw/wstubq.exe
    <CPCMD> wstub.asm           <RELROOT>/src/wstub.asm
    <CPCMD> wstub.c             <RELROOT>/src/wstub.c

[ BLOCK . . ]
#============
cdsay <PROJDIR>
