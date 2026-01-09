# TECHINFO Builder Control file
# =============================

set PROJDIR=<CWD>
set PROJNAME=techinfo

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

cdsay .

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dosi86/techinfo.exe <RELROOT>/binw/
    <CCCMD> <PROJDIR>/os2i86/techinfo.exe <RELROOT>/binp/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
