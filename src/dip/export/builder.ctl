# Export symbols DIP Builder Control file
# =======================================

set PROJDIR=<CWD>
set PROJNAME=export

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/defdylib.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dos386/<PROJNAME>.dip     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos386/<PROJNAME>.sym     <RELROOT>/binw/<PROJNAME>.dsy

    <CCCMD> <PROJDIR>/wini86/<PROJNAME>.dll     <RELROOT>/binw/
    <CCCMD> <PROJDIR>/wini86/<PROJNAME>.sym     <RELROOT>/binw/

    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.dll     <RELROOT>/binp/dll/
    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.sym     <RELROOT>/binp/dll/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.d32     <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym     <RELROOT>/binp/

    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.dll      <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym      <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.dip   <RELROOT>/binl/
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.sym   <RELROOT>/binl/

    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.dll      <RELROOT>/axpnt/
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.sym      <RELROOT>/axpnt/

    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.dip     <RELROOT>/qnx/watcom/wd/
    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.sym     <RELROOT>/qnx/sym/

    <CCCMD> <PROJDIR>/rdos386/<PROJNAME>.dll    <RELROOT>/rdos/
    <CCCMD> <PROJDIR>/rdos386/<PROJNAME>.sym    <RELROOT>/rdos/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
