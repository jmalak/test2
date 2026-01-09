# MS Compatible Tools Builder Control file
# ========================================

set PROJDIR=<CWD>
set PROJNAME=mstools

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE asaxp/builder.ctl ]
[ INCLUDE cl/builder.ctl ]
[ INCLUDE cvtres/builder.ctl ]
[ INCLUDE lib/builder.ctl ]
[ INCLUDE link/builder.ctl ]
[ INCLUDE nmake/builder.ctl ]
[ INCLUDE rc/builder.ctl ]

