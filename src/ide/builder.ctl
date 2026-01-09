# VIPER Builder Control file
# ==========================

set PROJDIR=<CWD>
set PROJNAME=IDE

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> viper.doc            <RELROOT>/ide.doc
    <CPCMD> cfg/ide.cfg          <RELROOT>/binw/ide.cfg
    <CPCMD> cfg/idedos.cfg       <RELROOT>/binw/idedos.cfg
    <CPCMD> cfg/idedos32.cfg     <RELROOT>/binw/idedos32.cfg
    <CPCMD> cfg/idewin.cfg       <RELROOT>/binw/idewin.cfg
    <CPCMD> cfg/ideos2.cfg       <RELROOT>/binw/ideos2.cfg
    <CPCMD> cfg/ideos232.cfg     <RELROOT>/binw/ideos232.cfg
    <CPCMD> cfg/idew32.cfg       <RELROOT>/binw/idew32.cfg
    <CPCMD> cfg/idew386.cfg      <RELROOT>/binw/idew386.cfg
    <CPCMD> cfg/idenlm.cfg       <RELROOT>/binw/idenlm.cfg
    <CPCMD> cfg/ideaxp.cfg       <RELROOT>/binw/ideaxp.cfg
    <CPCMD> cfg/idelnx.cfg       <RELROOT>/binw/idelnx.cfg
    <CPCMD> cfg/iderdos.cfg      <RELROOT>/binw/iderdos.cfg

    <CPCMD> cfg/ide.cfg          <RELROOT>/binl/ide.cfg
    <CPCMD> cfg/idedos.cfg       <RELROOT>/binl/idedos.cfg
    <CPCMD> cfg/idedos32.cfg     <RELROOT>/binl/idedos32.cfg
    <CPCMD> cfg/idewin.cfg       <RELROOT>/binl/idewin.cfg
    <CPCMD> cfg/ideos2.cfg       <RELROOT>/binl/ideos2.cfg
    <CPCMD> cfg/ideos232.cfg     <RELROOT>/binl/ideos232.cfg
    <CPCMD> cfg/idew32.cfg       <RELROOT>/binl/idew32.cfg
    <CPCMD> cfg/idew386.cfg      <RELROOT>/binl/idew386.cfg
    <CPCMD> cfg/idenlm.cfg       <RELROOT>/binl/idenlm.cfg
    <CPCMD> cfg/ideaxp.cfg       <RELROOT>/binl/ideaxp.cfg
    <CPCMD> cfg/idelnx.cfg       <RELROOT>/binl/idelnx.cfg
    <CPCMD> cfg/iderdos.cfg      <RELROOT>/binl/iderdos.cfg

    <CCCMD> viper/wini86/ide.exe <RELROOT>/binw/ide.exe
    <CCCMD> cfg/wini86/idex.cfg  <RELROOT>/binw/idex.cfg
    <CCCMD> viper/win/wsrv.pif   <RELROOT>/binw/wsrv.pif
    <CCCMD> viper/win/wd.pif     <RELROOT>/binw/wd.pif

    <CCCMD> viper/os2386/ide.exe <RELROOT>/binp/ide.exe
    <CCCMD> cfg/os2386/idex.cfg  <RELROOT>/binp/idex.cfg

    <CCCMD> viper/nt386/ide.exe  <RELROOT>/binnt/ide.exe
    <CCCMD> cfg/nt386/idex.cfg   <RELROOT>/binnt/idex.cfg

    <CCCMD> cfg/linux386/idex.cfg    <RELROOT>/binl/idex.cfg

    <CCCMD> viper/ntaxp/ide.exe  <RELROOT>/axpnt/ide.exe
    <CCCMD> cfg/axp/idex.cfg     <RELROOT>/axpnt/idex.cfg

[ BLOCK . . ]
#============
cdsay <PROJDIR>
