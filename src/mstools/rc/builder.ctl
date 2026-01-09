# mstools rc Builder Control file
# ===============================

set PROJDIR=<CWD>
set PROJNAME=rc
set CPDEFBIN=yes

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/rc.exe       <RELROOT>/binw/rc.exe
    <CCCMD> dos386/rc.sym       <RELROOT>/binw/rc.sym
    <CCCMD> os2386/rc.exe       <RELROOT>/binp/rc.exe
    <CCCMD> os2386/rc.sym       <RELROOT>/binp/rc.sym
    <CCCMD> nt386/rc.exe        <RELROOT>/binnt/rc.exe
    <CCCMD> nt386/rc.sym        <RELROOT>/binnt/rc.sym
    <CCCMD> ntaxp/rc.exe        <RELROOT>/axpnt/rc.exe
    <CCCMD> ntaxp/rc.sym        <RELROOT>/axpnt/rc.sym

[ BLOCK . . ]
#============

cdsay <PROJDIR>
