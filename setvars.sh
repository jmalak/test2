# Do not use directly; copy and modify as appropriate
# NB: This script must be sourced and not executed directly!

export P4PORT=perforce.openwatcom.org:3488
export P4USER=YourName
export P4PASSWD=YourPassword
export P4CLIENT=YourClient

# Change this only if automatic determination is unsatisfactory
OWROOT_CWD=`cd \`dirname -- $0\` && pwd`
# $OWROOT may differ from $OWROOT_CWD if symlinks are used
OWROOT=`cd \`dirname -- $0\` && pwd -P`

# Check that $OWROOT is not empty and that cmnvars.sh can be found
if [ -z "$OWROOT" ]; then
    echo "Failed to set OWROOT environment variable!"
    return 1
fi
if [ ! -e $OWROOT/cmnvars.sh ]; then
    echo "Failed to find \$OWROOT/cmnvars.sh! (OWROOT=$OWROOT)"
    return 2
fi

# Export $OWROOT now that it looks reasonable
export OWROOT

# Change this to point to your existing Open Watcom installation 
# if bootstrapping by host native tools is not desired
# export OWBOOTSTRAP=/usr/bin/watcom

# Change this to the PATH required by GhostScript for PDF creation on used host OS (optional)
export OWGHOSTSCRIPTPATH=/usr/bin

# Set this variable to 1 to get debug build
export OW_DEBUG_BUILD=0

# Set this variable to 1 to get default windowing support in clib
export OW_DEFAULT_WINDOWING=0

# Set this variable to 0 to suppress documentation build
export OW_DOC_BUILD=0

# Documentation related variables
# set appropriate variables to point Windows help compilers which you have installed
# export OW_HCRTF=hcrtf
# export OW_HHC=hhc

source $OWROOT/cmnvars.sh

cd $OWROOT_CWD

