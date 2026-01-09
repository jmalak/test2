# Debugger Trap Files/Servers Control file
# ========================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE lcl/builder.ctl ]
[ INCLUDE net/builder.ctl ]
[ INCLUDE nmp/builder.ctl ]
[ INCLUDE nov/builder.ctl ]
[ INCLUDE par/builder.ctl ]
[ INCLUDE ser/builder.ctl ]
[ INCLUDE tcp/builder.ctl ]
[ INCLUDE vdm/builder.ctl ]
[ INCLUDE win/builder.ctl ]

