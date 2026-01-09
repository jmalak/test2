# mstools nmake Builder Control file
# ==================================

set PROJDIR=<CWD>
set PROJNAME=nmake
set CPDEFBIN=yes

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/nmake.exe    <RELROOT>/binw/nmake.exe
    <CCCMD> dos386/nmake.sym    <RELROOT>/binw/nmake.sym
    <CCCMD> os2386/nmake.exe    <RELROOT>/binp/nmake.exe
    <CCCMD> os2386/nmake.sym    <RELROOT>/binp/nmake.sym
    <CCCMD> nt386/nmake.exe     <RELROOT>/binnt/nmake.exe
    <CCCMD> nt386/nmake.sym     <RELROOT>/binnt/nmake.sym
    <CCCMD> ntaxp/nmake.exe     <RELROOT>/axpnt/nmake.exe
    <CCCMD> ntaxp/nmake.sym     <RELROOT>/axpnt/nmake.sym

[ BLOCK . . ]
#============

cdsay <PROJDIR>
