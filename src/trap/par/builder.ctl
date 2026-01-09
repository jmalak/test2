# Parallel Port Debug Server/Trap Builder Control file
# ====================================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE trap/builder.ctl ]
[ INCLUDE srvr/builder.ctl ]

# Reset PROJDIR after included .ctl file changed it
set PROJDIR=<CWD>

# Special support for NT support driver.

[ BLOCK <1> build rel ]
#======================
    cdsay <PROJDIR>/ntsupp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/ntsuppow
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h

[ BLOCK <1> clean ]
#==================
    cdsay <PROJDIR>/ntsupp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/ntsuppow
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/ntsuppow/dbgport.sys  <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/ntsupp/dbginst.exe    <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/ntsupp/dbginst.sym    <RELROOT>/binnt/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
