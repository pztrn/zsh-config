# Launch fbterm on TTY login

# We should not use it on any system except linux.
if [[ "${OS}" != "Linux" ]]; then
    return
fi

# We should skip this file if no fbterm is installed.
FBTERM=`whereis fmterm | cut -d ":" -f 2`
if [[ "${FBTERM/fbterm}" == "${FBTERM}" ]]; then
    return
fi

# nVidia proprietary drivers will not allow us to use it, so we
# should disable this.

NVIDIA_POWERED=0
lsmod | grep nvidia &> /dev/null

if [ $? -eq 0 ]; then
    error 1 "Will not use FBTerm - nVidia proprietary driver detected"
    NVIDIA_POWERED=1
fi

if [ ${USE_FBTERM} -gt 0 ]; then
    if [ ${NVIDIA_POWERED} -ne 1 ]; then
        if [[ "$TTY" =~ ".*tty.*" ]] then
            fbterm
        fi
    fi
fi
