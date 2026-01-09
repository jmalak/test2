# Named Pipes Debug Server/Trap Builder Control file
# ==================================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE trap/builder.ctl ]
[ INCLUDE srvr/builder.ctl ]

# Reset PROJDIR after included .ctl file changed it
set PROJDIR=<CWD>

# Special support for nmpbind.exe; this is a helper utility
# needed for any named pipe support on OS/2.

[ BLOCK <1> build rel ]
#======================
    cdsay <PROJDIR>/nmpbind
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h

[ BLOCK <1> clean ]
#==================
    cdsay <PROJDIR>/nmpbind
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/nmpbind/nmpbind.exe      <RELROOT>/binp/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
