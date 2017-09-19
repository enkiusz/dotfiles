kpcli_getsecret() {
    local kdb_filename="$1"; shift
    local entry="$1"; shift

    local password=""
    echo -n "Enter master password to unlock '$keydb': "; read -s password
    echo "" > /dev/tty
    echo $password | kpcli --readonly --kdb "$kdb_filename" --pwfile=/dev/fd/0 --command="show -f \"$entry\"" | awk '/Pass:/ { print $2; }'
}
