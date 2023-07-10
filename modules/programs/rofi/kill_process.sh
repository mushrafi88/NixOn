#!/usr/bin/env bash

# Set Rofi theme
theme="kill_process_theme"
dir="$HOME/.config/rofi"

ALPHA="#00000000"
BG="#1E1E2E"
FG="#1A1B26"
SELECT="#C0CAF5"
ACCENT="#1A1B26"

# Overwrite colors file
cat > $dir/colors.rasi <<- EOF
	/* colors */

	* {
	  al:  $ALPHA;
	  bg:  $BG;
	  se:  $SELECT;
	  fg:  $FG;
	  ac:  $ACCENT;
	}
EOF

# Choose the running process
process_path=$(ps -e -o cmd | rofi -dmenu -no-lazy-grab -theme $dir/"$theme" -p "Enter process name")
[[ -z $process_path ]] && exit

# Get the base process name
process_name=$(basename -- "$process_path")

# Get process IDs
pid=$(pgrep -f "$process_name")
[[ -z $pid ]] && notify-send -t 9000 --icon=video-television "Not a valid process" && exit

# Kill the process
kill $pid

if [ $? -eq 0 ]; then
    dunstify  -a "killed $process_name" -i ~/.config/dunst/icon/sad.png -u "critical" -t 45000
else
    dunstify -a "Could not kill $process_name" -i ~/.config/dunst/icon/confused.jpg -u "normal" -t 45000
fi
