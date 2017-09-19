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
