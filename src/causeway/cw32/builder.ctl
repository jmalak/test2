# CauseWay DOS Extender Builder Control file
# ==========================================

set PROJDIR=<CWD>
set PROJNAME=cw32

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dosi86/cw32.exe           <RELROOT>/binw/cwstub.exe
    <CCCMD> <PROJDIR>/dosi86/cwdstub.exe        <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos386/cwdll.lib          <RELROOT>/lib386/dos/
    <CPCMD> <PROJDIR>/../inc/cwdllfnc.h         <RELROOT>/h/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
