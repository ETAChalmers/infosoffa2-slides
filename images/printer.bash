PRINTER_IP="10.30.12.7"

LOGIN="maker:gEzPcY9tZbsfMPx"
status=$(curl -u "$LOGIN" --digest -s "$PRINTER_IP/api/v1/status")

if echo "$status" | jq -e 'has("job") | not' >/dev/null ; then
    echo "no print in progress"
    exit
fi
job=$(curl -u "$LOGIN" --digest -s "$PRINTER_IP/api/v1/job")
state=$(echo "$job" | jq -r '.state')
if [ "$state" != "PRINTING" ] ; then
    echo "print in progress but not in PRINTING state"
    exit
fi
time_printing_h=$(echo "$job" | jq -r '.time_printing / 3600 | floor')
time_printing_m=$(echo "$job" | jq -r '.time_printing / 60 | floor | . % 60')
time_left_h=$(echo "$job" | jq -r '.time_remaining / 3600 | floor')
time_left_m=$(echo "$job" | jq -r '.time_remaining / 60 | floor | . % 60')
time_left_kvart=$(echo "$job" | jq -r '.time_remaining / 60 / 15 | floor')

echo $time_left_kvart

kvar_lol="felsök ditt senaste projekt"
if [ $time_left_kvart -le 1 ] ; then
    kvar_lol="köp en sanne och kom tillbaka"
elif [ $time_left_kvart -le 2 ] ; then
    kvar_lol="etsa ett kretskort och kom tillbaka"
elif [ $time_left_kvart -le 3 ] ; then
    kvar_lol="etsa ett kretskort och gör fel"
elif [ $time_left_kvart -le 6 ] ; then # 1:30
    kvar_lol="käka lunch och kom tillbaka"
elif [ $time_left_kvart -eq 8 ] ; then # 2:00
    kvar_lol="gå på föreläsning och kom tillbaka"
elif [ $time_left_kvart -eq 16 ] ; then # 4:00
    kvar_lol="gå på föreläsning och kom tillbaka"
elif [ $time_left_kvart -eq 24 ] ; then # 6:00
    kvar_lol="gå och sortera"
fi

name=$(echo "$job" | jq -r '.file.display_name')

echo "printing $name for ${time_printing_h}h ${time_printing_m}m, ${time_left_h}h ${time_left_m}m left"
echo "loading icon"
icon_url=$(echo "$job" | jq -r '.file.refs.thumbnail')
curl -u "$LOGIN" --digest -s "$PRINTER_IP$icon_url" > /tmp/print.png

echo "rendering image"

basepath=$(dirname "$0")

convert -font Courier -size 1920x1080 -background black -fill white canvas:none \
    -pointsize 30 \
    -draw "text 50,50 \"Printing $name"\" \
    -draw "image over 50,80 56,30 \"$basepath/ETA-logga.png\"" \
    -draw "text 115,100 \"$kvar_lol\"" \
    -draw "text 50,140 \"(printat i ${time_printing_h}h ${time_printing_m}m, ${time_left_h}h ${time_left_m}m kvar)\"" \
    -draw 'image over 306,160 1307,980 "/tmp/print.png"' \
    "/tmp/rendered.png"

sudo fbi -comments -d /dev/fb0 -vt 1 -1 -t 30 "/tmp/rendered.png"
sleep 30
