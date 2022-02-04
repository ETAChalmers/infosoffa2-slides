figlet -w 240 'F@h ETA Leaderboard
Team ID: 254957'

data=$(curl https://api.foldingathome.org/team/254957/members 2> /dev/null)

echo $data | jq -r '.[1:10] | to_entries[] | (.key+1|tostring) + ". " + (.value[3]|tostring) + " " + .value[0]' | figlet -w 240