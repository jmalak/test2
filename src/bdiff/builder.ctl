# bdiff/bpatch Builder Control file
# =================================

set PROJDIR=<CWD>
set PROJNAME=bdiff

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

cdsay .

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dos386/bdiff.exe     <RELROOT>/binw/bdiff.exe
    <CCCMD> <PROJDIR>/dos386/bpatch.exe    <RELROOT>/binw/bpatch.exe

    <CCCMD> <PROJDIR>/os2386/bdiff.exe     <RELROOT>/binp/bdiff.exe
    <CCCMD> <PROJDIR>/os2386/bpatch.exe    <RELROOT>/binp/bpatch.exe

    <CCCMD> <PROJDIR>/nt386/bdiff.exe      <RELROOT>/binnt/bdiff.exe
    <CCCMD> <PROJDIR>/nt386/bpatch.exe     <RELROOT>/binnt/bpatch.exe

[ BLOCK . . ]
#============
cdsay <PROJDIR>
