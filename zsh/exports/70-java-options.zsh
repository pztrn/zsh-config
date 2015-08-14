# Java-specific exports.
# More or less pretty fonts in Java programs.
# It should be exported only if we have X session running.
if [ ! -z ${DISPLAY} ]; then
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
    export JAVA_FONTS=/usr/share/fonts/TTF
fi
