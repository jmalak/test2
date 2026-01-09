# mstools link Builder Control file
# =================================

set PROJDIR=<CWD>
set PROJNAME=link
set CPDEFBIN=yes

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/link.exe     <RELROOT>/binw/link.exe
    <CCCMD> dos386/link.sym     <RELROOT>/binw/link.sym
    <CCCMD> os2386/link.exe     <RELROOT>/binp/link.exe
    <CCCMD> os2386/link.sym     <RELROOT>/binp/link.sym
    <CCCMD> nt386/link.exe      <RELROOT>/binnt/link.exe
    <CCCMD> nt386/link.sym      <RELROOT>/binnt/link.sym
    <CCCMD> nt386/link386.exe   <RELROOT>/binnt/link386.exe
    <CCCMD> nt386/link386.sym   <RELROOT>/binnt/link386.sym
    <CCCMD> nt386/linkaxp.exe   <RELROOT>/binnt/linkaxp.exe
    <CCCMD> nt386/linkaxp.sym   <RELROOT>/binnt/linkaxp.sym
    <CCCMD> ntaxp/link.exe      <RELROOT>/axpnt/link.exe
    <CCCMD> ntaxp/link.sym      <RELROOT>/axpnt/link.sym

[ BLOCK <1> boot ]
#=================
# Copy additional bootstrap executables besides link.exe
    <CPCMD> <OWOBJDIR>/link386.exe  <OWBINDIR>/link386.exe

[ BLOCK <1> bootclean ]
#======================
# Clean up additional bootstrap executables besides link.exe
    echo rm -f <OWBINDIR>/link386.exe
    rm -f <OWBINDIR>/link386.exe

[ BLOCK . . ]
#============

cdsay <PROJDIR>
