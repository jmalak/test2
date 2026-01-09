# Debugger Local Trap Files Control file
# ======================================

set PROJDIR=<CWD>
set PROJNAME=trap

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]


[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> <PROJDIR>/dos/dosr/dos.std/std.trp              <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/rsi/dos.trp/rsi.trp          <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/rsi/dos.srv/rsihelp.exp      <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/pls/dos.trp/pls.trp          <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/pls/dos.srv/plshelp.exp      <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/pls/dosped.srv/pedhelp.exp   <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/cw/dos.trp/cw.trp            <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/cw/dos.srv/cwhelp.exe        <RELROOT>/binw/
    <CCCMD> <PROJDIR>/dos/dosx/cw/dos.srv/cwhelp.cfg        <RELROOT>/binw/

    <CCCMD> <PROJDIR>/os2v2/std/std.d32                     <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2v2/wvpmhelp/wdpmhook.dll           <RELROOT>/binp/dll/
    <CCCMD> <PROJDIR>/os2v2/wvpmhelp/wdpmhelp.exe           <RELROOT>/binp/
    <CCCMD> <PROJDIR>/os2v2/splice/wdsplice.dll             <RELROOT>/binp/dll/

#os2
#    <CCCMD> <PROJDIR>/os2/std16/std16.dll                   <RELROOT>/binp/dll/std.dll

    <CCCMD> <PROJDIR>/win/std/std.dll                       <RELROOT>/binw/
    <CCCMD> <PROJDIR>/win/int32/wint32.dll                  <RELROOT>/binw/

    <CCCMD> <PROJDIR>/nt/std/std.dll                        <RELROOT>/binnt/

    <CCCMD> <PROJDIR>/nt/stdaxp/std.dll                     <RELROOT>/axpnt/

    <CCCMD> <PROJDIR>/qnx/pmd/pmd.trp                       <RELROOT>/qnx/watcom/wd/
    <CCCMD> <PROJDIR>/qnx/std/std.trp                       <RELROOT>/qnx/watcom/wd/

    <CCCMD> <PROJDIR>/linux/std/std.trp                     <RELROOT>/binl/

    <CCCMD> <PROJDIR>/rdos/std/std.dll                      <RELROOT>/rdos/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
