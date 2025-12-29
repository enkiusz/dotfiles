keepass_password() {
    local kdb_filename="$1"; shift
    local entry="$1"; shift

    keepassxc-cli show --attributes password --show-protected "$kdb_filename" "$entry"
}
