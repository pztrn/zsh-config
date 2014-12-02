export PATH="/home/pztrn/bin:/usr/lib:/usr/lib/colorgcc/bin:/usr/sbin:/sbin:/usr/local/heroku/bin:/data/Programs/hyde:$PATH"
export EDITOR=nano

# More or less pretty fonts in Java programs.
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export JAVA_FONTS=/usr/share/fonts/TTF

# PyENV.
export PYENV_ROOT="/data/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
