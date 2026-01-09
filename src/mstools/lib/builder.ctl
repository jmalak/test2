# mstools lib Builder Control file
# ================================

set PROJDIR=<CWD>
set PROJNAME=lib

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/lib.exe      <RELROOT>/binw/lib.exe
    <CCCMD> dos386/lib.sym      <RELROOT>/binw/lib.sym
    <CCCMD> os2386/lib.exe      <RELROOT>/binp/lib.exe
    <CCCMD> os2386/lib.sym      <RELROOT>/binp/lib.sym
    <CCCMD> nt386/lib.exe       <RELROOT>/binnt/lib.exe
    <CCCMD> nt386/lib.sym       <RELROOT>/binnt/lib.sym
    <CCCMD> nt386/lib386.exe    <RELROOT>/binnt/lib386.exe
    <CCCMD> nt386/lib386.sym    <RELROOT>/binnt/lib386.sym
    <CCCMD> ntaxp/lib.exe       <RELROOT>/axpnt/lib.exe
    <CCCMD> ntaxp/lib.sym       <RELROOT>/axpnt/lib.sym

[ BLOCK . . ]
#============

cdsay <PROJDIR>
