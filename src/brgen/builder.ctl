# Source Browser Info Generator Builder Control file
# ==================================================

set PROJDIR=<CWD>
set PROJNAME=brgen

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/wbrg.exe     <RELROOT>/binw/wbrg.exe
    <CCCMD> os2386/wbrg.exe     <RELROOT>/binp/wbrg.exe
    <CCCMD> nt386/wbrg.exe      <RELROOT>/binnt/wbrg.exe
    <CCCMD> ntaxp/wbrg.exe      <RELROOT>/axpnt/wbrg.exe

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
