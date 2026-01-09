# Novell IPX Trap Builder Control file
# ====================================

set PROJDIR=<CWD>
set PROJNAME=nov

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/defdylib.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.trp     <RELROOT>/binw/
#    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym     <RELROOT>/binw/

    <CCCMD> <PROJDIR>/wini86/<PROJNAME>.dll     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/wini86/<PROJNAME>.sym     <RELROOT>/binw/

#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.dll     <RELROOT>/binp/dll/
#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.sym     <RELROOT>/binp/dll/

    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.dll      <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym      <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.dll      <RELROOT>/axpnt/
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.sym      <RELROOT>/axpnt/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
