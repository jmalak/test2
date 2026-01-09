# mstools asaxp Builder Control file
# ==================================

set PROJDIR=<CWD>
set PROJNAME=asaxp

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/asaxp.exe    <RELROOT>/binw/asaxp.exe
    <CCCMD> dos386/asaxp.sym    <RELROOT>/binw/asaxp.sym
    <CCCMD> os2386/asaxp.exe    <RELROOT>/binp/asaxp.exe
    <CCCMD> os2386/asaxp.sym    <RELROOT>/binp/asaxp.sym
    <CCCMD> nt386/asaxp.exe     <RELROOT>/binnt/asaxp.exe
    <CCCMD> nt386/asaxp.sym     <RELROOT>/binnt/asaxp.sym
    <CCCMD> ntaxp/asaxp.exe     <RELROOT>/axpnt/asaxp.exe
    <CCCMD> ntaxp/asaxp.sym     <RELROOT>/axpnt/asaxp.sym

[ BLOCK . . ]
#============

cdsay <PROJDIR>
