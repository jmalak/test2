# wasmps Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=wasmps

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dos386/<PROJNAME>.exe     <RELROOT>/binw/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe     <RELROOT>/binp/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe      <RELROOT>/binnt/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.exe      <RELROOT>/axpnt/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.exe   <RELROOT>/binl/<PROJNAME>

[ BLOCK . . ]
#============
    cdsay .

