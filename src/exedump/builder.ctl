# WDUMP Builder Control file
# ==========================

set PROJDIR=<CWD>
set PROJNAME=wdump

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]


[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.exe     <RELROOT>/binw/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe     <RELROOT>/binp/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe      <RELROOT>/binnt/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.exe      <RELROOT>/axpnt/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.exe     <RELROOT>/qnx/<PROJNAME>
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.exe   <RELROOT>/binl/<PROJNAME>

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
