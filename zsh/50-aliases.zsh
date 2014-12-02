alias screen="TERM=xterm screen"

# AION ^_^
#alias aion="cd /data/Programs/aion/ && WINEPREFIX="/home/pztrn/.wine-aion" wine AWLite.exe"

# SVN Add all in ABUILDS
#alias addall="cd /data/AgiliaLinux/ABUILDS && sh svnadd.sh"

# VirtualBox Aliases
alias as-start='VBoxManage startvm "Arch Linux Server" --type headless'
alias as-stop='VBoxManage controlvm "Arch Linux Server" acpipowerbutton'

alias x86_64-start='VBoxManage startvm "Agilia x86_64" --type headless'
alias x86_64-stop='VBoxManage controlvm "Agilia x86_64" acpipowerbutton'

# QTile
alias qtcfg="nano ~/.config/qtile/config.py"

# Games
alias regnum="/data/Programs/Regnum/rolauncher"
alias ut2004="aoss /data/Programs/UT2004/ut2004"

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#source /home/pztrn/.rvm/scripts/rvm

# Xilitra
alias xbs="/data/XILITRA/xbs/src/xbs.py"
alias deptracker="/data/XILITRA/xilitra-dev-tools/deptracker/deptracker"
alias xpkg="/data/XILITRA/xpkg/src/xpkg.py"

# Other
alias clocksync="sudo ntpdate 0.pool.ntp.org"
alias got="git"

# Blogs
alias crotal="/data/.pyenv/versions/2.7.6/bin/crotal"

#alias yasearch="yaourt -Ss"
#alias yainstall="yaourt -S"
#alias yadel="yaourt -Rd"
#alias sysupdate="yaourt -Syua"
#alias flvgrab="ffmpeg -f alsa -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec flv -sameq"
