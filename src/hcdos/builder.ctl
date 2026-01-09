# hcdos Builder Control file
# ==========================

set PROJDIR=<CWD>
set PROJNAME=hcdos

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ INCLUDE <OWROOT>/build/deftool.ctl ]

cdsay <PROJDIR>
