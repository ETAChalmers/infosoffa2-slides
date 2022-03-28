QUOTE_PATH="infosoffa2-slides/quotes.json"
# QUOTE_PATH="../quotes.json"

QUOTE=$(jq -r '.[] | .quote + "\\n - " + .author' $QUOTE_PATH | shuf -n 1)

echo "$QUOTE" | figlet -w $(tput cols) -f basic
