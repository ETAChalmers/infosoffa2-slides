URL="https://coral.shoes/morse-trainer/data/quotes.json"

QUOTE=$(curl -s "$URL" | jq -r '.[] | .quote + "\\n - " + .author' $QUOTE_PATH | shuf -n 1)

echo "$QUOTE" | figlet -w $(tput cols)
