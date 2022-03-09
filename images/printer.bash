PRINTER_IP="192.168.30.173"


ENDPOINT="$PRINTER_IP/api/telemetry"
data=$(curl -s "$ENDPOINT")

time_left=$(echo "$data" | jq -r '.time_est')
progress=$(echo "$data" | jq -r '.progress')
thing=$(echo "$data" | jq -r '.project_name')

minutes=$(($time_left/60%60))
hours=$(($time_left/60/60%60))

if [[ hours -eq 0 ]] ; then
    timedesc="${minutes}m"
else
    timedesc="${hours}h ${minutes}m"
fi

progress_desc="Progress: $progress%, $timedesc left"

width=$(tput cols)
echo "Currently printing" | figlet -w $width
echo "$thing" | figlet -w $width


echo "$progress_desc" | figlet -w $width
