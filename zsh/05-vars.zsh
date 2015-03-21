# This file includes some variables that vital to all parts of
# this configuration.

OS=`uname`
OS_RELEASE=`uname -r`

# Variable forcers.

# If DEBUG isn't defined - force it to be 0.
if [ -z ${DEBUG} ]; then
    DEBUG=0
    return 1
fi
