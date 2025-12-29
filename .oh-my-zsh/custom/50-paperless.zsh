
sortimages() {
    feh --cache-thumbnails --draw-actions --draw-tinted --sort mtime \
        --action1="mv %F $HOME/Dokumenty/Skany/paragony/" \
        --action2="mv %F $HOME/Dokumenty/Skany/blank-pages" \
        --action3="mv %f $HOME/Dokumenty/Skany/junk" \
        -. .
}

sortblanks() {
    feh --cache-thumbnails --draw-actions --draw-tinted --sort mtime \
        --action1="mv %F $HOME/Dokumenty/Skany/blank-fp" \
        -. .
}

