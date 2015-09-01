# Don't run anything here unless we have an interactive shell.
if [[ $- != *i* ]] ; then
    return
fi

# Prevent ^S and ^Q from locking up the display
stty -ixon

# Setup colors for ls
eval $(dircolors)

# Bash options
# Reference: http://www.caliban.org/bash/
export HISTIGNORE="&:mc:mutt:ls"

export EDITOR="/usr/bin/emacsclient"
export VISUAL="$EDITOR"

export ACRONYMDB="/usr/share/misc/acronyms /usr/share/misc/acronyms.comp $HOME/share/misc/acronyms"

export STOW_DIR="$HOME/stow"
xstow -no-curses -d "$STOW_DIR" -ire "^(README.md|.git)$" $(cd $STOW_DIR; echo *)

alias sel="xclip -selection clipboard -o"
alias bkg="time nice -n 19 ionice -c 3" # Useful for running daily emerge
alias reload="source $HOME/.bashrc"
alias kbugz="bugz --connection kernel"
alias burp="java -jar $HOME/bin/burpsuite_free_*.jar &"
alias pulseloop="pactl load-module module-loopback latency_msec=1"
alias ls="ls -B --color=auto"

torget() {
    while [ "$1" ]; do
	local info_hash=$(echo "$1" | tr 'a-f' 'A-F'); shift
	local url="https://torcache.net/torrent/$info_hash.torrent"
	local http_status=$(curl -L -s -o /dev/null -w "%{http_code}" "$url")
	if [ "$http_status" == "200" ]; then
	    curl "$url" | gzip -d > "$info_hash.torrent"
	else
	    echo "Fetching '$url' resulted in HTTP response code '$http_status', skipping."
	fi
    done
}

# Return the size of the specified screen
# If screen ID is not specified then '0' is assubmed.
screensize() {
    SCREEN_ID="$1"; shift
    [ -z "$SCREEN_ID" ] && SCREEN_ID=0

    xrandr --screen "$SCREEN_ID" -q --properties | awk -F',' '/Screen [[:digit:]]+:/ { print substr($2, match($2, "[[:digit:]]+[[:space:]]*x[[:space:]]*[[:digit:]]")); }' | tr -d '[[:space:]]'
}

# Record a screencast
alias rec='ffmpeg -f x11grab -s $(screensize 0) -r 25 -i :0.0 -qscale 0'
alias sht='ffmpeg -f x11grab -s $(screensize 0) -i :0.0 screenshot-$(date -u "+%Y%m%dT%H%M%SZ").png'

xdg-user-dirs-update
[ -r ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs

export PATH="$HOME/bin:$PATH"

# Setup perl local::lib
# http://cpan.uwinnipeg.ca/htdocs/local-lib/local/lib.html
PERL5HOME="${HOME}/.local/perl5"
[ -r "${PERL5HOME}/lib/perl5/local/lib.pm" ] && eval $(perl -I${PERL5HOME}/lib/perl5 -Mlocal::lib=${PERL5HOME})

# Run esekeyd on the main keyboard, used for volume control
unset KBD_EVENT_DEV
for h in /dev/input/event*; do 
    PROPS=$(udevadm info --query=property --name=$h)

    echo -ne "$PROPS" | grep -Fq "ID_INPUT_KEYBOARD=1" || continue # Skip if not a keyboard
    echo -ne "$PROPS" | grep -Fq "ID_SERIAL=01f3_52c0" || continue

    KBD_EVENT_DEV=$h; break
done

/usr/sbin/esekeyd $HOME/.esekeyd.conf "$KBD_EVENT_DEV" $XDG_RUNTIME_DIR/esekeyd.pid

# Load private bashrc if provided
[ -x "$HOME/.bashrc.private" ] && source "$HOME/.bashrc.private"
