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
