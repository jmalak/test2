# mstools cl Builder Control file
# ===============================

set PROJDIR=<CWD>
set PROJNAME=cl

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

# Can't use default deftool.ctl due to non-default extension
[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/cl.nex       <RELROOT>/binw/cl.exe
    <CCCMD> dos386/cl.sym       <RELROOT>/binw/cl.sym
    <CCCMD> os2386/cl.nex       <RELROOT>/binp/cl.exe
    <CCCMD> os2386/cl.sym       <RELROOT>/binp/cl.sym
    <CCCMD> nt386/cl.nex        <RELROOT>/binnt/cl.exe
    <CCCMD> nt386/cl386.nex     <RELROOT>/binnt/cl386.exe
    <CCCMD> nt386/cl386.sym     <RELROOT>/binnt/cl386.sym
    <CCCMD> nt386/claxp.nex     <RELROOT>/binnt/claxp.exe
    <CCCMD> nt386/claxp.sym     <RELROOT>/binnt/claxp.sym
    <CCCMD> ntaxp/cl.nex        <RELROOT>/axpnt/cl.exe
    <CCCMD> ntaxp/cl.sym        <RELROOT>/axpnt/cl.sym

[ BLOCK <1> boot ]
#=================
    <CPCMD> <OWOBJDIR>/cl.nex       <OWBINDIR>/cl.exe
    <CPCMD> <OWOBJDIR>/cl386.nex    <OWBINDIR>/cl386.exe

[ BLOCK <1> bootclean ]
#======================
# Clean up bootstrap executables
    echo rm -f <OWBINDIR>/cl.exe
    rm -f <OWBINDIR>/cl.exe
    echo rm -f <OWBINDIR>/cl386.exe
    rm -f <OWBINDIR>/cl386.exe

[ BLOCK . . ]
#============

cdsay <PROJDIR>
