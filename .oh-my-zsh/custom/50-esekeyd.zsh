# Run esekeyd on the main keyboard, used for volume control
if [ -x "$(which esekeyd 2>/dev/null)" ]; then
    unset KBD_EVENT_DEV
    for h in /dev/input/event*; do 
        PROPS=$(udevadm info --query=property --name=$h)

        echo -ne "$PROPS" | grep -Fq "ID_INPUT_KEYBOARD=1" || continue # Skip if not a keyboard
        echo -ne "$PROPS" | grep -Fq "ID_SERIAL=01f3_52c0" || continue

        KBD_EVENT_DEV=$h; break
    done

    /usr/sbin/esekeyd $HOME/.esekeyd.conf "$KBD_EVENT_DEV" $XDG_RUNTIME_DIR/esekeyd.pid
fi
