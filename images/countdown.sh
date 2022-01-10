for _ in $(seq 0 10) ; do
    clear
    cat <<'EOF'

888    d8P                                          d8b           .d888 d8b 888                        
888   d8P                                           Y8P          d88P"  Y8P 888                        
888  d8P                                                         888        888                        
888d88K      .d88b.  88888b.d88b.        88888b.   8888b.        888888 888 888  888  8888b.           
8888888b    d88""88b 888 "888 "88b       888 "88b     "88b       888    888 888 .88P     "88b          
888  Y88b   888  888 888  888  888       888  888 .d888888       888    888 888888K  .d888888          
888   Y88b  Y88..88P 888  888  888       888 d88P 888  888       888    888 888 "88b 888  888          
888    Y88b  "Y88P"  888  888  888       88888P"  "Y888888       888    888 888  888 "Y888888          
                                         888                                                           
                                         888                                                           
                                         888                                                           
                                                                                                       
88888888888 d8b               888                          d888   8888888888      .d8888b.   .d8888b.  
    888     Y8P               888                         d8888         d88P     d88P  Y88b d88P  Y88b 
    888                       888                           888        d88P           .d88P 888    888 
    888     888 .d8888b   .d88888  8888b.   .d88b.          888       d88P   d8b     8888"  888    888 
    888     888 88K      d88" 888     "88b d88P"88b         888    88888888  Y8P      "Y8b. 888    888 
    888     888 "Y8888b. 888  888 .d888888 888  888         888     d88P         888    888 888    888 
    888     888      X88 Y88b 888 888  888 Y88b 888         888    d88P      d8b Y88b  d88P Y88b  d88P 
    888     888  88888P'  "Y88888 "Y888888  "Y88888       8888888 d88P       Y8P  "Y8888P"   "Y8888P"  
                                                888                                                    
                                           Y8b d88P                                                    
                                            "Y88P"


EOF
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

    result += f"{seconds} {'sekunder' if seconds > 1 else 'sekund'}"

    return result

tuesday = datetime.datetime.now()
while tuesday.weekday() != 1:
    tuesday = tuesday + datetime.timedelta(days=1)

tisdagsfika = datetime.datetime.replace(tuesday, hour=17, minute=30, second=0, microsecond=0)

time_left = tisdagsfika - datetime.datetime.now()

print("Countdown:")
print(timedelta_format(time_left))
EOF
    sleep 1
done
exit 100
