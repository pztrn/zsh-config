# PyENV exports.

# This exports should work only if config states this.
if [ "${USE_PYENV}" -eq 0 ]; then
    return
fi

export PYENV_ROOT="${PYENV_PATH}"
export PATH="${PYENV_PATH}/bin:$PATH"
eval "$(pyenv init -)"
