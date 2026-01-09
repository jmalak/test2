# NetBIOS Remote Server Builder Control file
# ==========================================

set PROJDIR=<CWD>
set PROJNAME=netserv

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================

    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.exe    <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dosi86/<PROJNAME>.sym    <RELROOT>/binw/

    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.exe   <RELROOT>/binw/
    <CCCMD> <PROJDIR>/wini86/<PROJNAME>w.sym   <RELROOT>/binw/

#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.exe    <RELROOT>/binp/dll/
#    <CCCMD> <PROJDIR>/os2i86/<PROJNAME>.sym    <RELROOT>/binp/dll/

    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe    <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym    <RELROOT>/binp/

    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe     <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym     <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.exe     <RELROOT>/axpnt/
    <CCCMD> <PROJDIR>/ntaxp/<PROJNAME>.sym     <RELROOT>/axpnt/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
