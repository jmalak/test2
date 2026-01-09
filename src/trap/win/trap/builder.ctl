# WinLink Trap Builder Control file
# =================================

set PROJDIR=<CWD>
set PROJNAME=win

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/defdylib.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.trp     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym     <RELROOT>/binw/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
