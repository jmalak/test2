# Source Browser Builder Control file
# ===================================

set PROJDIR=<CWD>
set PROJNAME=browser

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

# pmake priorities are used to build:
# 1) dlgprs/o
# 2) gen
# 3) everywhere else.
#
# gen is dependent on dlgprs/o
# the os_dos dlgprs/o and gen are dependent on windows.h and not selected.


[ BLOCK <1> rel cprel ]
#======================
    cdsay <PROJDIR>
    <CCCMD> wini86/wbrw.exe        <RELROOT>/binw/wbrw.exe
    <CCCMD> os2386/wbrw.exe        <RELROOT>/binp/wbrw.exe
    <CPCMD> nt386/wbrw.exe         <RELROOT>/binnt/wbrw.exe
    <CCCMD> axpnt/wbrw.exe         <RELROOT>/axpnt/wbrw.exe

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
