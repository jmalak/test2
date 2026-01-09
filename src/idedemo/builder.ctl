# IDE Demo Builder Control file
# =============================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ BLOCK <1> build rel ]
#======================
# This project is very special because the (generated) makefiles are meant
# to be used in a standard environment with installed tools. The WATCOM
# environment variable must approximate a typical installation.

    set OLD_WATCOM=<WATCOM>
    set WATCOM=<OWROOT>/rel

    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h
    cdsay <PROJDIR>

    cdsay src/os2
    echo ide2make -r drawos2.tgt -c <OWROOT>/src/ide/cfg/ide.cfg
    ide2make -r drawos2.tgt -c      <OWROOT>/src/ide/cfg/ide.cfg
    wmake -i -h -f drawos2.mk1      <OWROOT>/src/idedemo/src/os2/box.obj
    wmake -i -h -f drawos2.mk1      <OWROOT>/src/idedemo/src/os2/drawroom.obj
    wmake -i -h -f drawos2.mk1      <OWROOT>/src/idedemo/src/os2/furnitu.obj

    cdsay ../win
    echo ide2make -r draw16.tgt -c <OWROOT>/src/ide/cfg/ide.cfg
    ide2make -r draw16.tgt -c      <OWROOT>/src/ide/cfg/ide.cfg
    wmake -i -h -f draw16.mk1      <OWROOT>/src/idedemo/src/win/box.obj
    wmake -i -h -f draw16.mk1      <OWROOT>/src/idedemo/src/win/drawroom.obj
    wmake -i -h -f draw16.mk1      <OWROOT>/src/idedemo/src/win/furnitu.obj

    cdsay ../win386
    echo ide2make -r draw.tgt -c <OWROOT>/src/ide/cfg/ide.cfg
    ide2make -r draw.tgt -c      <OWROOT>/src/ide/cfg/ide.cfg
    wmake -i -h -f draw.mk1      <OWROOT>/src/idedemo/src/win386/box.obj
    wmake -i -h -f draw.mk1      <OWROOT>/src/idedemo/src/win386/drawroom.obj
    wmake -i -h -f draw.mk1      <OWROOT>/src/idedemo/src/win386/furnitu.obj

    cdsay ../win32
    echo ide2make -r draw.tgt -c <OWROOT>/src/ide/cfg/ide.cfg
    ide2make -r draw32.tgt -c    <OWROOT>/src/ide/cfg/ide.cfg
    wmake -i -h -f draw32.mk1    <OWROOT>/src/idedemo/src/win32/box.obj
    wmake -i -h -f draw32.mk1    <OWROOT>/src/idedemo/src/win32/drawroom.obj
    wmake -i -h -f draw32.mk1    <OWROOT>/src/idedemo/src/win32/furnitu.obj

    set WATCOM=<OLD_WATCOM>
    cd <PROJDIR>

[ BLOCK <1> rel ]
#================
    cdsay <PROJDIR>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> src/*.*                 <RELROOT>/samples/ide/
    <CCCMD> src/fortran/*.*         <RELROOT>/samples/ide/fortran/
    <CCCMD> src/fortran/win32/*.*   <RELROOT>/samples/ide/fortran/win32/
    <CCCMD> src/fortran/os2/*.*     <RELROOT>/samples/ide/fortran/os2/
    <CCCMD> src/fortran/win/*.*     <RELROOT>/samples/ide/fortran/win/
    <CCCMD> src/fortran/win386/*.*  <RELROOT>/samples/ide/fortran/win386/
    <CCCMD> src/win32/*.tgt         <RELROOT>/samples/ide/win32/
    <CCCMD> src/os2/*.tgt           <RELROOT>/samples/ide/os2/
    <CCCMD> src/win/*.tgt           <RELROOT>/samples/ide/win/
    <CCCMD> src/win386/*.tgt        <RELROOT>/samples/ide/win386/

    <CCCMD> threed/os2/os2_3d.dll   <RELROOT>/samples/ide/
    <CCCMD> threed/os2/os2_3d.dll   <RELROOT>/samples/ide/os2/
    <CCCMD> threed/os2/os2_3d.dll   <RELROOT>/samples/ide/fortran/
    <CCCMD> threed/os2/os2_3d.dll   <RELROOT>/samples/ide/fortran/os2/

    <CCCMD> threed/nt/nt_3d.dll     <RELROOT>/samples/ide/win32/
    <CCCMD> threed/nt/nt_3d.dll     <RELROOT>/samples/ide/fortran/win32/

    <CCCMD> threed/win/win_3d.dll   <RELROOT>/samples/ide/win/
    <CCCMD> threed/win/win_3d.dll   <RELROOT>/samples/ide/win386/
    <CCCMD> threed/win/win_3d.dll   <RELROOT>/samples/ide/fortran/win/
    <CCCMD> threed/win/win_3d.dll   <RELROOT>/samples/ide/fortran/win386/

    <CCCMD> src/os2/box.obj         <RELROOT>/samples/ide/fortran/os2/
    <CCCMD> src/os2/drawroom.obj    <RELROOT>/samples/ide/fortran/os2/
    <CCCMD> src/os2/furnitu.obj     <RELROOT>/samples/ide/fortran/os2/
    <CCCMD> src/win/box.obj         <RELROOT>/samples/ide/fortran/win/
    <CCCMD> src/win/drawroom.obj    <RELROOT>/samples/ide/fortran/win/
    <CCCMD> src/win/furnitu.obj     <RELROOT>/samples/ide/fortran/win/
    <CCCMD> src/win386/box.obj      <RELROOT>/samples/ide/fortran/win386/
    <CCCMD> src/win386/drawroom.obj <RELROOT>/samples/ide/fortran/win386/
    <CCCMD> src/win386/furnitu.obj  <RELROOT>/samples/ide/fortran/win386/
    <CCCMD> src/win32/box.obj       <RELROOT>/samples/ide/fortran/win32/
    <CCCMD> src/win32/drawroom.obj  <RELROOT>/samples/ide/fortran/win32/
    <CCCMD> src/win32/furnitu.obj   <RELROOT>/samples/ide/fortran/win32/

[ BLOCK <1> clean ]
#==================
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean
    wmake -i -h -f clean.mif

[ BLOCK . . ]
#============
    cdsay <PROJDIR>
