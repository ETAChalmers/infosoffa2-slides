if [ $(($RANDOM%$5)) -lt 1 ]; then
    infosoffa2-slides/stl-viewer/stl-viewer infosoffa2-slides/stl-viewer/kalle-micro.stl
else
    infosoffa2-slides/stl-viewer/stl-viewer infosoffa2-slides/stl-viewer/among.stl
fi
exit 100
