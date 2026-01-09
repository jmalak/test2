# Resource Tools Builder Control file
# ===================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ BLOCK <1> build rel ]
#======================
    cdsay <PROJDIR>/mkcdpg
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/exedmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/restest
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/res2res
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/rescmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>/wresdmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/wresdmp/dosi86/wresdmp.exe        <RELROOT>/binw/
    <CCCMD> <PROJDIR>/exedmp/os2386/exedmp.exe          <RELROOT>/binp/
    <CCCMD> <PROJDIR>/wresdmp/os2386/wresdmp.exe        <RELROOT>/binp/
    <CCCMD> <PROJDIR>/mkcdpg/nt386/mkcdpg.exe           <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/exedmp/nt386/exedmp.exe           <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/wresdmp/nt386/wresdmp.exe         <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/rescmp/nt386/rescmp.exe           <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/res2res/nt386/res2res.exe         <RELROOT>/binnt/
    <CCCMD> <PROJDIR>/mkcdpg/ntaxp/mkcdpg.exe           <RELROOT>/axpnt/

[ BLOCK <1> clean ]
#==================
    cdsay <PROJDIR>/mkcdpg
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/exedmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/restest
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/res2res
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/rescmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    cdsay <PROJDIR>/wresdmp
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean

[ BLOCK . . ]
#============
cdsay <PROJDIR>
