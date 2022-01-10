for _ in {0..10} ; do
    clear
    echo
    echo
    echo
    echo
    python3 <<'EOF' | figlet -w 230
import datetime

def timedelta_format(duration):
    seconds = duration.total_seconds()

    hours, seconds = divmod(round(seconds), 3600)
    minutes, seconds = divmod(seconds, 60)

    result = ""
    if hours:
        result += f"{hours} {'timmar' if hours > 1 else 'timme'}, "
    if minutes:
        result += f"{minutes} {'minuter' if minutes > 1 else 'minut'} och "

    result += f"{seconds} {'sekunder' if minutes > 1 else 'sekund'}"

    return result

tuesday = datetime.datetime.now()
while tuesday.weekday() != 1:
    tuesday = tuesday + datetime.timedelta(days=1)

tisdagsfika = datetime.datetime.replace(tuesday, hour=17, minute=30, second=0, microsecond=0)

time_left = tisdagsfika - datetime.datetime.now()

print("Tisdagsfika om")
print(timedelta_format(time_left))
EOF
    sleep 1
done
exit 100
