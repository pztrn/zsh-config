# chruby sourcing.

# This exports should work only if config states this.
if [ "${USE_CHRUBY}" -eq 0 ]; then
    return
fi

export CHRUBY_ROOT="${CHRUBY_PATH}"
source "${CHRUBY_ROOT}/chruby.sh"
source "${CHRUBY_ROOT}/auto.sh"
