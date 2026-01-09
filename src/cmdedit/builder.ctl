# ce Builder Control file
# =======================

set PROJDIR=<CWD>
set PROJNAME=cvpack

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>


[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> cmdedit.txt         <RELROOT>/binw/cmdedit.txt

    <CCCMD> dosi86/cmdedit.exe  <RELROOT>/binw/cmdedit.exe

    <CCCMD> os2i86/os2edit.exe  <RELROOT>/binp/os2edit.exe
    <CCCMD> os2i86/os22edit.exe <RELROOT>/binp/os22edit.exe
    <CCCMD> os2i86/os2edit.dll  <RELROOT>/binp/dll/os2edit.dll


[ BLOCK . . ]
#============
    cdsay <PROJDIR>
