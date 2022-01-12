#!/bin/bash

curl http://wd.cfab.chalmers.se/pages/station/liveData.php --silent --output ~/infosoffa2-slides/data_curl.html
file=$(echo "cat //html/body/div/div/table/tr/td/div" |  xmllint --html --shell ~/infosoffa2-slides/data_curl.html)
rm -f ~/infosoffa2-slides/data_curl.html

#MMmMMmm RegEx
re='([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)([0-9.]+)([^0-9]*)'
#file="$(cat tmp_w_data)"
#echo $file
if [[ $file =~ $re ]];
        then
        tempe="${BASH_REMATCH[1]}"
        humid="${BASH_REMATCH[3]}"
        press="${BASH_REMATCH[5]}"
        wind="${BASH_REMATCH[7]}"
        wind_inst="${BASH_REMATCH[9]}"
        rain="${BASH_REMATCH[11]}"
        sun="${BASH_REMATCH[13]}"

fi
clear
echo '888     888 d8b  d8b      888                  888             d8b                   888'
echo '888     888 Y8P  Y8P      888                  888             Y8P                   888'
echo '888     888               888                  888                                   888'
echo 'Y88b   d88P  8888b.   .d88888 888d888  .d88b.  888888         8888 888  888 .d8888b  888888       88888b.  888  888'
echo ' Y88b d88P      "88b d88" 888 888P"   d8P  Y8b 888            "888 888  888 88K      888          888 "88b 888  888'
echo '  Y88o88P   .d888888 888  888 888     88888888 888             888 888  888 "Y8888b. 888          888  888 888  888'
echo '   Y888P    888  888 Y88b 888 888     Y8b.     Y88b.           888 Y88b 888      X88 Y88b.        888  888 Y88b 888'
echo '    Y8P     "Y888888  "Y88888 888      "Y8888   "Y888          888   Y88888  88888P    Y888       888  888   Y88888'
echo '                                                               888'
echo '                                                              d88P'
echo '                                                           888P'
figlet -w 160 -f standard Temp = $tempe C
figlet -w 160 -f standard Luftfuktighet = $humid %
figlet -w 160 -f standard Vindhastighet = $wind [$wind_inst] m/s
figlet -w 160 -f standard Solstyrka = $sun W/m2
