# TCP/IP Remote Server Builder Control file
# =========================================

set PROJDIR=<CWD>
set PROJNAME=tcpserv

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.exe   <RELROOT>/binw/
    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.sym   <RELROOT>/binw/

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.exe    <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym    <RELROOT>/binw/<PROJNAME>.dsy

#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.exe    <RELROOT>/binp/dll/
#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.sym    <RELROOT>/binp/dll/

    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe    <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym    <RELROOT>/binp/

    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe     <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym     <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.exe  <RELROOT>/binl/<PROJNAME>
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.sym  <RELROOT>/binl/

    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.exe     <RELROOT>/axpnt/
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.sym     <RELROOT>/axpnt/

    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.qnx    <RELROOT>/qnx/bin/<PROJNAME>
    <CCCMD> <PROJDIR>/qnx386/<PROJNAME>.sym    <RELROOT>/qnx/sym/

    <CCCMD> <PROJDIR>/rdos386/<PROJNAME>.exe   <RELROOT>/rdos/
    <CCCMD> <PROJDIR>/rdos386/<PROJNAME>.sym   <RELROOT>/rdos/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
