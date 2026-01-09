# UNINSTAL Builder Control file
# =============================

set PROJDIR=<CWD>
set PROJNAME=uninstal

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> <2> rel cprel ]
#==========================
    <CCCMD> nt386/uninstal.exe <RELROOT>/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
