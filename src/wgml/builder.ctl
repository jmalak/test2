# wgml Builder Control file
# =========================

set PROJDIR=<CWD>
set PROJNAME=wgml

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> boot ]
#=================
    <CPCMD> <OWOBJDIR>/wgml.exe <OWBINDIR>/wgml<CMDEXT>

[ BLOCK <1> bootclean ]
#======================
    echo rm -f <OWBINDIR>/wgml<CMDEXT>
    rm -f <OWBINDIR>/wgml<CMDEXT>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dos386/wgml.exe   <RELROOT>/binw/wgml.exe
    <CCCMD> <PROJDIR>/dos386/wgml.sym   <RELROOT>/binw/wgml.sym

    <CCCMD> <PROJDIR>/nt386/wgml.exe    <RELROOT>/binnt/wgml.exe
    <CCCMD> <PROJDIR>/nt386/wgml.sym    <RELROOT>/binnt/wgml.sym

    <CCCMD> <PROJDIR>/os2386/wgml.exe   <RELROOT>/binp/wgml.exe
    <CCCMD> <PROJDIR>/os2386/wgml.sym   <RELROOT>/binp/wgml.sym

    <CCCMD> <PROJDIR>/linux386/wgml.exe <RELROOT>/binl/wgml
    <CCCMD> <PROJDIR>/linux386/wgml.sym <RELROOT>/binl/wgml.sym
    
[ BLOCK . . ]
#============
cdsay <PROJDIR>
