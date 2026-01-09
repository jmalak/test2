# w32api Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=w32api

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

cdsay .

[ BLOCK <1> rel cprel ]
#======================
    <CPCMD> readme.txt                  <RELROOT>/readme.w32

    <CPCMD> nt/*.h                      <RELROOT>/h/nt/
    <CPCMD> nt/*.rh                     <RELROOT>/h/nt/
    <CPCMD> nt/gl/*.h                   <RELROOT>/h/nt/gl/
    <CPCMD> nt/ddk/*.h                  <RELROOT>/h/nt/ddk/
    <CPCMD> nt/directx/*.h              <RELROOT>/h/nt/directx/

    <CPCMD> nt386/*.lib                 <RELROOT>/lib386/nt/
    <CPCMD> nt386/ddk/*.lib             <RELROOT>/lib386/nt/ddk/
    <CPCMD> nt386/directx/*.lib         <RELROOT>/lib386/nt/directx/

#    <CPCMD> ntaxp/*.lib                 <RELROOT>/libaxp/nt/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
