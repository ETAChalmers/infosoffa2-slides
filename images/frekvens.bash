echo ' __      __  _   _                    __                 _                                                    _   _             __   _   _            _     _   _   _    __   _   _   _   _          _'
echo ' \ \    / / (_) (_)                  / _|               | |                                                  (_) (_)           / _| (_) (_)          | |   (_) | | | |  / _| (_) (_) | | | |        | |'
echo '  \ \  / /    __ _    __ _    __ _  | |_   _ __    ___  | | __ __   __   ___   _ __    ___    ___   _ __       __ _   _ __    | |_    ___    _ __    | |_   _  | | | | | |_    __ _  | | | |   ___  | |_'
echo '   \ \/ /    / _` |  / _` |  / _` | |  _| | "__|  / _ \ | |/ / \ \ / /  / _ \ | "_ \  / __|  / _ \ | "_ \     / _` | | "__|   |  _|  / _ \  | "__|   | __| | | | | | | |  _|  / _` | | | | |  / _ \ | __|'
echo '    \  /    | (_| | | (_| | | (_| | | |   | |    |  __/ |   <   \ V /  |  __/ | | | | \__ \ |  __/ | | | |   | (_| | | |      | |   | (_) | | |      | |_  | | | | | | | |   | (_| | | | | | |  __/ | |_ '
echo '     \/      \__,_|  \__, |  \__, | |_|   |_|     \___| |_|\_\   \_/    \___| |_| |_| |___/  \___| |_| |_|    \__,_| |_|      |_|    \___/  |_|       \__| |_| |_| |_| |_|    \__,_| |_| |_|  \___|  \__|'
echo '                      __/ |   __/ |                                                                                                                                                                      '
echo '                     |___/   |___/'


data=$(curl -s -X GET --header 'Accept: application/json' 'https://driftsdata.statnett.no/RestApi/Frequency/BySecond')

ndata=$(echo "$data" | jq '.Measurements | length')

extra_points=10
y0=14
x0=20
h=50
w=$(($ndata+$extra_points))

if [[ $(($RANDOM%2)) -eq 1 ]] ; then
    # Hz
    CONVERSION=1.0
    UNIT="Hz"
    mid=50
    hertz_per_px=0.001
else
    # rad/s
    CONVERSION=$(echo "2*3.141592" | bc)
    UNIT="rad/s"
    mid=313
    hertz_per_px=$(echo "0.313*0.313" | bc)
fi

function move_to_xy {
    printf "\x1b[$(($h-$2+$y0));$(($1+$x0))H"

}
function move_to_graph {
    move_to_xy $((2*$1)) $2
}

draw_start=0

min=$(echo "$mid-($h/2)*$hertz_per_px" | bc | tr -d '\n' ; printf "$UNIT")
min_l=$(echo "$min" | wc -c | tr -d ' ')
max=$(echo "$mid+($h/2)*$hertz_per_px" | bc | tr -d '\n' ; printf "$UNIT")
max_l=$(echo "$max" | wc -c | tr -d ' ')
mmid=$(printf "%d$UNIT" $mid)
mmid_l=$(echo "$mmid" | wc -c | tr -d ' ')

move_to_xy $((-$min_l-1)) 0
printf "$min"
move_to_xy $((-$max_l-1)) $h
printf "$max"

max=$(echo "$mid+($h/2)*$hertz_per_px" | bc)
move_to_xy $((-$mmid_l-1)) $(($h/2))
printf "$mmid "

for y in $(seq 0 $h) ; do
    move_to_graph -1 $y
    printf ' |'
    move_to_graph $w $y
    printf '|'
done

for x in $(seq 0 $(($w-1))) ; do
    move_to_graph $x 0
    printf '%s' '--'
    move_to_graph $x $h
    printf '%s' '--'

    move_to_graph $x $(($h/2))
    printf '%s' ' -'
done


last_y="NULL"
# takes x point, y value
function put_point {
    y=$(echo "scale=5;$h/2+($2-$mid)/$hertz_per_px" | bc)
    yi=$(echo "$y" | awk '{print int($1+0.5)}')

    if [[ "$last_y" = "NULL" ]] ; then
        syi="$yi"
    else
        sy=$(echo "scale=5;($last_y+$h/2+($2-$mid)/$hertz_per_px)/2" | bc)
        syi=$(echo "$sy" | awk '{print int($1+0.5)}')
    fi

    move_to_graph "$1" $yi
    printf " #"
    move_to_graph "$1" $syi
    printf "#"
    last_y="$yi"
}

px=0
for point in $(echo "$data" | jq '.Measurements | .[]') ; do
    point=$(echo "$point*$CONVERSION" | bc)
    put_point $px "$point"
    px=$((px+1))
done

for x in $(seq 1 $extra_points) ; do
    if [[ $x -ne 0 ]] ; then
        data=$(curl -s -X GET --header 'Accept: application/json' 'https://driftsdata.statnett.no/RestApi/Frequency/BySecond')
    fi
    F=$(echo "$data" | jq -rj '.Measurements[-1]')
    F=$(echo "$F*$CONVERSION" | bc)

    printf "\x1b[8;1H"
    printf "                                                 %.4f $UNIT    \x00" "$F" | figlet -w 230

    put_point $px "$F"
    px=$((px+1))

    sleep 1
done

exit 100
