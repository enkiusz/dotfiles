mp3len() {
    total=0
    while [ "$1" ]; do
        filename="$1"; shift
        time=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$filename")
        echo $time $filename
        total=$(echo "$total + $time" | bc)
    done
    echo "$total *total"
}
