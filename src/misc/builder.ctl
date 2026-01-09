# MISC Builder Control file
# =========================

set PROJDIR=<CWD>
set PROJNAME=misc

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================

    <CPCMD> <OWROOT>/src/misc/unicode*      <RELROOT>/binw/
    <CPCMD> <OWROOT>/src/misc/watcom.ico    <RELROOT>/
    <CPCMD> <OWROOT>/src/misc/unicode*      <RELROOT>/binl/
    <CPCMD> <OWROOT>/license.txt            <RELROOT>/license.txt

# NT, OS2 32-bit version
    <CCCMD> <OWROOT>/src/wres/flat386/mf_r/wres.lib  <RELROOT>/lib386/wresf.lib
    <CCCMD> <OWROOT>/src/wres/flat386/mf_s/wres.lib  <RELROOT>/lib386/wresfs.lib
# OSI 32-bit version
    <CCCMD> <OWROOT>/src/wres/small386/ms_r/wres.lib <RELROOT>/lib386/osi/wresf.lib
    <CCCMD> <OWROOT>/src/wres/small386/ms_s/wres.lib <RELROOT>/lib386/osi/wresfs.lib
# DOS 32-bit version
    <CCCMD> <OWROOT>/src/wres/small386/ms_r/wres.lib <RELROOT>/lib386/dos/wresf.lib
    <CCCMD> <OWROOT>/src/wres/small386/ms_s/wres.lib <RELROOT>/lib386/dos/wresfs.lib
# AXP version
    <CCCMD> <OWROOT>/src/wres/ntaxp/_s/wres.lib   <RELROOT>/libaxp/
# LINUX version
    <CCCMD> <OWROOT>/src/wres/linux386/mf_r/wres.lib <RELROOT>/lib386/linux/wresf.lib
    <CCCMD> <OWROOT>/src/wres/linux386/mf_s/wres.lib <RELROOT>/lib386/linux/wresfs.lib
# QNX version
    <CCCMD> <OWROOT>/src/wres/qnx386/ms_r/wres.lib <RELROOT>/lib386/qnx/wresf.lib
    <CCCMD> <OWROOT>/src/wres/qnx386/ms_s/wres.lib <RELROOT>/lib386/qnx/wresfs.lib

# DOS 16-bit version
#    <CCCMD> <OWROOT>/src/wres/dosi86/mm/wres.lib    <RELROOT>/lib286/wresm.lib
#    <CCCMD> <OWROOT>/src/wres/dosi86/ml/wres.lib    <RELROOT>/lib286/wresl.lib
#    <CCCMD> <OWROOT>/src/wres/dosi86/ms/wres.lib   <RELROOT>/lib286/wress.lib
#    <CCCMD> <OWROOT>/src/wres/dosi86/mc/wres.lib   <RELROOT>/lib286/wresc.lib
#    <CCCMD> <OWROOT>/src/wres/dosi86/mh/wres.lib   <RELROOT>/lib286/wresh.lib
# OS2 16-bit version
#    <CCCMD> <OWROOT>/src/wres/os2i86/ml/wres.lib    <RELROOT>/lib286/os2/wresl.lib

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
