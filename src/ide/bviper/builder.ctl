# ide2make Builder Control file
# =============================

set PROJDIR=<CWD>
set PROJNAME=ide2make
set CPDEFBIN=yes

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dos386/<PROJNAME>.exe      <RELROOT>/binw/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/dos386/<PROJNAME>.sym      <RELROOT>/binw/<PROJNAME>.sym
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.exe      <RELROOT>/binp/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/os2386/<PROJNAME>.sym      <RELROOT>/binp/<PROJNAME>.sym
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.exe       <RELROOT>/binnt/<PROJNAME>.exe
    <CCCMD> <PROJDIR>/nt386/<PROJNAME>.sym       <RELROOT>/binnt/<PROJNAME>.sym
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.exe    <RELROOT>/binl/<PROJNAME>
    <CCCMD> <PROJDIR>/linux386/<PROJNAME>.sym    <RELROOT>/binl/<PROJNAME>.sym

[ BLOCK . . ]
#============
cdsay <PROJDIR>
