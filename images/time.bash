echo '888    d8P  888                   888                              d8b  d8b'
echo '888   d8P   888                   888                              Y8P  Y8P'
echo '888  d8P    888                   888'
echo '888d88K     888  .d88b.   .d8888b 888  888  8888b.  88888b.         8888b.  888d888'
echo '8888888b    888 d88""88b d88P"    888 .88P     "88b 888 "88b           "88b 888P"'
echo '888  Y88b   888 888  888 888      888888K  .d888888 888  888       .d888888 888'
echo '888   Y88b  888 Y88..88P Y88b.    888 "88b 888  888 888  888       888  888 888'
echo '888    Y88b 888  "Y88P"   "Y8888P 888  888 "Y888888 888  888       "Y888888 888'

for _ in $(seq 0 10) ; do
    printf "\x1b[10;1H"
    (date +%s | tr -d "\n" ; printf "        \x00" ) | figlet -w 230
    sleep 1
done

exit 100
