clear

WIDTH=$(tput cols)
HEIGHT=$(tput lines)

IMAGE_PATH="/home/pi/infosoffa2-slides/images"
# IMAGE_PATH="$(pwd)/images"

while true
do
    IDX=1
    # TODO: fillistan splitas vid mellanslag, borde ha ett bättre sätt
    count=$(echo $IMAGE_PATH/* | wc -w | tr -d ' ')

	for file in $(ls $IMAGE_PATH/* | shuf)
	do
                interpreter=${file#*.}

                if [ "$interpreter" == $file ]
		then
			interpreter=cat
		fi

        bar=$(yes "#" | head -n $IDX | tr -d '\n' ; yes "." | head -n $(($count-$IDX+1)) | tr -d '\n')
        bottom_text="$(basename $file) - [ $bar ] "

        w=$(echo "$bottom_text" | wc -c)
        x=$((WIDTH-w))

        printf "\x1b[$HEIGHT;${x}H$bottom_text\x1b[1;1H"

		if [ $(($RANDOM%100)) -lt 1 ]
                then
			$interpreter "$file" | /home/pi/infosoffa2-slides/better_lolcat/rainbow
			exit_code=$?
		else
			$interpreter "$file"
			exit_code=$?
		fi
		if [ $exit_code -ne 100 ]
		then
			sleep 10
		fi
		clear

		IDX=$((IDX+1))
	done
done
