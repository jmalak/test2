# WinLink Server Builder Control file
# ===================================

set PROJDIR=<CWD>
set PROJNAME=winserv

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.exe     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym     <RELROOT>/binw/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
