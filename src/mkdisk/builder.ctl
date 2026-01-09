# mkdisk Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=mkdisk

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> boot ]
#============================
    cdsay <PROJDIR>
    <CPCMD> <PROJDIR>/<OWOBJDIR>/mkexezip.exe   <OWBINDIR>/mkexezip<CMDEXT>
    <CPCMD> <PROJDIR>/<OWOBJDIR>/uzip.exe       <OWBINDIR>/uzip<CMDEXT>
    <CPCMD> <PROJDIR>/<OWOBJDIR>/langdat.exe    <OWBINDIR>/langdat<CMDEXT>
    <CPCMD> <PROJDIR>/<OWOBJDIR>/mkinf.exe      <OWBINDIR>/mkinf<CMDEXT>

[ BLOCK <1> bootclean ]
#======================
    rm -f <OWBINDIR>/mkexezip<CMDEXT>
    rm -f <OWBINDIR>/uzip<CMDEXT>
    rm -f <OWBINDIR>/langdat<CMDEXT>
    rm -f <OWBINDIR>/mkinf<CMDEXT>

[ BLOCK . . ]
#============
cdsay <PROJDIR>
