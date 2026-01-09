# Named Pipes Trap Builder Control file
# =====================================

set PROJDIR=<CWD>
set PROJNAME=nmp

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

    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.d32     <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym     <RELROOT>/binp/

#    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.dll      <RELROOT>/binnt/
#    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym      <RELROOT>/binnt/


[ BLOCK . . ]
#============
cdsay <PROJDIR>
