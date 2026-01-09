# mstools cvtres Builder Control file
# ==================================

set PROJDIR=<CWD>
set PROJNAME=cvtres

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/cvtres.exe   <RELROOT>/binw/cvtres.exe
    <CCCMD> dos386/cvtres.sym   <RELROOT>/binw/cvtres.sym
    <CCCMD> os2386/cvtres.exe   <RELROOT>/binp/cvtres.exe
    <CCCMD> os2386/cvtres.sym   <RELROOT>/binp/cvtres.sym
    <CCCMD> nt386/cvtres.exe    <RELROOT>/binnt/cvtres.exe
    <CCCMD> nt386/cvtres.sym    <RELROOT>/binnt/cvtres.sym
    <CCCMD> ntaxp/cvtres.exe    <RELROOT>/axpnt/cvtres.exe
    <CCCMD> ntaxp/cvtres.sym    <RELROOT>/axpnt/cvtres.sym

[ BLOCK . . ]
#============

cdsay <PROJDIR>
