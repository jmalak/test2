# Documentation Builder Control file
# ==================================

set PROJDIR=<CWD>
set PROJNAME=docs

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]


[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> dos/*.ihp       <RELROOT>/binw/
    <CPCMD> win/*.hlp       <RELROOT>/binw/
    <CPCMD> os2/*.inf       <RELROOT>/binp/help/
    <CPCMD> os2/*.hlp       <RELROOT>/binp/help/
    <CCCMD> nt/*.hlp        <RELROOT>/binnt/
    <CCCMD> nt/*.cnt        <RELROOT>/binnt/
    <CCCMD> htmlhelp/*.chm  <RELROOT>/binnt/help/
    <CCCMD> pdf/*.pdf       <RELROOT>/docs/
    <CPCMD> readme.txt      <RELROOT>/readme.txt
    <CPCMD> freadme.txt     <RELROOT>/freadme.txt
    <CPCMD> areadme.txt     <RELROOT>/areadme.txt
    <CPCMD> instlic.txt     <RELROOT>/instlic.txt

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
