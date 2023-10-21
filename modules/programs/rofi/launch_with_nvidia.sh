#!/usr/bin/env bash

# Set the Rofi theme and directory
theme="launcher_theme"
dir="$HOME/.config/rofi"

# Define the colors
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

# Show Rofi with a custom prompt
selected_program=$(rofi -dmenu -p "nvidia:" -theme $dir/"$theme")

# Check if a program was selected
if [ -n "$selected_program" ]; then
    # Run the nvidia-offload command before the selected program
    nvidia-offload "$selected_program"
fi
