# Installer builder control file
# ==============================

set PROJDIR=<CWD>
set PROJNAME=Installer

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ BLOCK <1> build rel ]
#======================
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h

[ BLOCK <1> clean ]
#==================
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean

[ BLOCK <1> missing ]
    ############################################################
    # This is hack can be used to create installers when some
    # distribution files are missing (e.g. help files).
    # Dummy zero-length files are created by running mkinf -x.
    ############################################################
    langdat c
    mkinf -x -i../include c filelist <RELROOT>
    langdat f77
    mkinf -x -i../include f77 filelist <RELROOT>
    rm filelist

[ BLOCK . . ]
cdsay .
