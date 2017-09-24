#!/bin/bash
MSG="`cat`"
SENT=$(date --date "$(grep -m1 '^Date: ' <<< "$MSG" | sed -e 's/Date://')" +%s)
[ $SENT ] || exit
#RECV=$(date --date "$(grep '^From ' $FILE | cut -d' ' -f 3-)" +%s)
RECV=$(date +%s)
T=$(($RECV-$SENT))
if (($T>31104000)); then
    Y="$(bc <<< $T/60/60/24/365)y, "
    MO="$(bc <<< $T/60/60/24%365/30)mon, "
    W="$(bc <<< $T/60/60/24%365%30/7)w, "
    D="$(bc <<< $T/60/60/24%365%30%7)d"
elif (($T>2592000)); then
    MO="$(bc <<< $T/60/60/24/30)mon, "
    W="$(bc <<< $T/60/60/24%30/7)w, "
    D="$(bc <<< $T/60/60/24%30%7)d"
    #H="$(bc <<< $T/60/60%24)h"
elif (($T>604800)); then
    W="$(bc <<< $T/60/60/24/7)w, "
    D="$(bc <<< $T/60/60/24%7)d, "
    H="$(bc <<< $T/60/60%24)h"
elif (($T>86400)); then
    D="$(bc <<< $T/60/60/24)d, "
    H="$(bc <<< $T/60/60%24)h "
    #M="$(bc <<< $T/60%60)m"
elif (($T>3600)); then
    H="$(bc <<< $T/60/60)h "
    M="$(bc <<< $T/60%60)m"
else
    M="$(printf %02d $(bc <<< $T/60%60))min"
fi

T="$Y$MO$W$D$H$M"
sed "/^Date: / {
    n
    i\
    X-Time-Since: $T
}" <<< "$MSG" 
