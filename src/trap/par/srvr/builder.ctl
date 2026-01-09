# Parallel Port Remote Server Builder Control file
# ================================================

set PROJDIR=<CWD>
set PROJNAME=parserv

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

#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>1.exe    <RELROOT>/binp/
#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>1.sym    <RELROOT>/binp/

    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe     <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym     <RELROOT>/binp/

    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe      <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym      <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.exe      <RELROOT>/axpnt/
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.sym      <RELROOT>/axpnt/

    <CCCMD> <PROJDIR>/nov386/<PROJNAME>3.nlm    <RELROOT>/nlm/
    <CCCMD> <PROJDIR>/nov386.v4/<PROJNAME>4.nlm <RELROOT>/nlm/

    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.qnx     <RELROOT>/binq/<PROJNAME>
    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.sym     <RELROOT>/binq/

    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.exe   <RELROOT>/binl/<PROJNAME>
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.sym   <RELROOT>/binl/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
