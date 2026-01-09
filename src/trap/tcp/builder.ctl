# TCP/IP Debug Server/Trap Builder Control file
# =============================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE trap/builder.ctl ]
[ INCLUDE srvr/builder.ctl ]

