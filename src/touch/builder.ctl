# wtouch Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=wtouch
set CPDEFBIN=yes

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dosi86/wtouch.exe   <RELROOT>/binw/wtouch.exe
    <CCCMD> os2386/wtouch.exe   <RELROOT>/binp/wtouch.exe
    <CCCMD> nt386/wtouch.exe    <RELROOT>/binnt/wtouch.exe
    <CCCMD> ntaxp/wtouch.exe    <RELROOT>/axpnt/wtouch.exe
    <CCCMD> linux386/wtouch.exe <RELROOT>/binl/wtouch

[ BLOCK . . ]
#============
cdsay <PROJDIR>
