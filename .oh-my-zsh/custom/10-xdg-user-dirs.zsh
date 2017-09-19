type xdg-user-dirs-update > /dev/null && xdg-user-dirs-update
[ -r ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs
