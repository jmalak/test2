# VDM Remote Server Builder Control file
# ======================================

set PROJDIR=<CWD>
set PROJNAME=vdmserv

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.exe     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym     <RELROOT>/binw/

    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.exe    <RELROOT>/binw/
    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.sym    <RELROOT>/binw/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
