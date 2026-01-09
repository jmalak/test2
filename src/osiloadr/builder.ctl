# OSI Loader (w32ldr) Builder Control file
# ========================================

set PROJDIR=<CWD>
set PROJNAME=osildr

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/cwsrun.exe   <RELROOT>/binw/w32run.exe
#    <CCCMD> dos386/x32run.exe   <RELROOT>/binw/x32run.exe
#    <CCCMD> dos386/x32run.exe   <RELROOT>/binw/x32run.exe
#    <CCCMD> dos386/d4grun.exe   <RELROOT>/binw/d4grun.exe
#    <CCCMD> dos386/tntrun.exe   <RELROOT>/binw/tntrun.exe

#    <CCCMD> os2386/w32bind.exe  ../build/binp/w32bind.exe
#    <CCCMD> os2386/os2ldr.exe   ../build/binp/os2ldr.exe

    <CCCMD> nt386/w32run.exe    <RELROOT>/binnt/w32run.exe

[ BLOCK . . ]
#============
cdsay <PROJDIR>
