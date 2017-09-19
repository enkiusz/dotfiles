modern.ie_manage() {
    COMMAND="$1"; VM="$2"; SUBCOMMAND="$3"; shift 3
    VBoxManage "$COMMAND" "$VM" "$SUBCOMMAND" --username IEUser --password Passw0rd! $@
}

modern.ie_cmd() {
    VM="$1"; shift
    modern.ie_manage guestcontrol "$VM" exec --image cmd.exe --wait-stdout --wait-stderr --wait-exit -- /c $@
}
# Install chocolatey @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
