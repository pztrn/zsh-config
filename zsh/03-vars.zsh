# This file includes some variables that vital to all parts of
# this configuration.

OS=`uname`
OS_RELEASE=`uname -r`
OS_ARCH=`uname -m`

# Distro detection.
LSBRELEASE=$(which lsb_release)
if [ $? -eq 0 ]; then
  DISTRO=`lsb_release -i -s`
else
  # BSDs OS and macOS can be detected via uname.
  DISTRO=${OS}
fi

# Variable forcers.

# If DEBUG isn't defined - force it to be 0.
if [ -z ${DEBUG} ]; then
    DEBUG=0
    return 1
fi
