#pmake: build os_win cpu_i86
#
# Open Watcom Debugger makefile for Windows console
#

host_os  = win
host_cpu = i86

# Required to pick the right wres library
!define WINDOWS

sysobjs =   &
    autoenv.obj &
    wininit.obj &
    winchk.obj &
    wincmd.obj &
    winfilio.obj &
    winlkup.obj &
    winscrn.obj

!include ../../master.mif
