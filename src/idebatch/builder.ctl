# IDE Batch Server Builder Control file
# =====================================

set PROJDIR=<CWD>
set PROJNAME=batserv

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]


[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <OWROOT>/src/idebatch/os2/batserv.exe       <RELROOT>/binp/batserv.exe
    <CCCMD> <OWROOT>/src/idebatch/nt/batserv.exe        <RELROOT>/binnt/batserv.exe
    <CCCMD> <OWROOT>/src/idebatch/dos/int.exe           <RELROOT>/binw/dosserv.exe
# there is no makefile in the wini86 dir
    <CCCMD> <OWROOT>/src/idebatch/wini86/batchbox.pif   <RELROOT>/binw/batchbox.pif
    <CCCMD> <OWROOT>/src/idebatch/nt/axp/batserv.exe    <RELROOT>/axpnt/batserv.exe

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
