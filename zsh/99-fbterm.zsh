# Launch fbterm on TTY login

# But first some pre-checks. nVidia proprietary drivers will not allow
# us to use it, so we should disable this.

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
