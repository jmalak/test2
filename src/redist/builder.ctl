# Redistributable binary files control file
# =========================================

set PROJDIR=<CWD>
set PROJNAME=examples

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> <OWROOT>/src/redist/dos4gw/*        <RELROOT>/binw/
    <CPCMD> <OWROOT>/src/redist/dos32a/*        <RELROOT>/binw/
    <CPCMD> <OWROOT>/src/redist/pmodew/*        <RELROOT>/binw/

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
