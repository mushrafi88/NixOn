{ config, lib, pkgs, ... }:

let
  rofi_todo = pkgs.writeShellScriptBin "rofi_todo" ''
        #!/usr/bin/bash

    rm -rf ~/Notes/today.txt
    #mkdir -p ~/Notes/tmp

    weekday=$(date +"%A")
    up_weekday=$(echo "$weekday" | tr '[:lower:]' '[:upper:]')

    while IFS= read -r line
    do
        IFS=';' read -ra parts <<< "$line"
        task_name="''${parts[0]}"
        task_detail="''${parts[1]}"
        task_time="''${parts[2]}"
        task_day="''${parts[3]:-EVERYDAY}"
        task_day="$(echo "$task_day" | tr '[:lower:]' '[:upper:]' | xargs)"

        if [[ "$task_day" == "$up_weekday" ]] || [[ "$task_day" == "EVERYDAY" ]]; then
            formatted_task=$(printf "%-20s %-30s %-10s %s\n" "''${task_name}" "''${task_detail}" "''${task_time}" "''${task_day}")
            echo "$formatted_task" >> ~/Notes/today.txt
        fi
    done < ~/Notes/todo.txt

    if [ -s ~/Notes/today.txt ]
    then
        rofi_command="rofi -dmenu -i -p \"Today's Tasks:\" -no-custom -width 80 -format i -theme $HOME/.config/rofi/drun_theme.rasi"
        task_list=$(cat ~/Notes/today.txt | sed '/^$/d')
        selected_task=$(echo -e "''${task_list}" | eval $rofi_command)

        if [ -n "$selected_task" ]; then
            selected_line=$(echo "$task_list" | sed -n "$(($selected_task + 1))p")
            echo "Selected task: $selected_line"
        fi
    else
        echo "No tasks for today."
    fi

    	'';
  dunst_todo = pkgs.writeShellScriptBin "dunst_todo" ''
            #!/usr/bin/bash
    while true
    do
        primary=$(cat ~/Notes/today.txt | grep -oP ".*\s+\d+:\d+(?:am|pm)")
        sorted=""
        while read -r line
        do
            data=$(echo "$line" | grep -oP "\d+:\d+(?:am|pm)")
            new=$(date --date="$data" +%s)
            destro=$(echo "$line" | sed -e "s/\s\+\([0-9]\+:[0-9]\+\(am\|pm\)\)//" -e "s/^/$new /")
            sorted=$(echo -e "$sorted\n$destro")
        done <<< "$primary"

        sorted=$(echo "$sorted" | sort -k1)
        time=$(date +"%I:%M%P")
        cur_time_epoch=$(date --date="$time today" +%s)
        while read -r line
        do
            ex_time=$(echo "$line" | awk '{print $1}')
            difference=$((cur_time_epoch-ex_time))
            diff=$(echo "$difference" | sed 's/^-//g')
            if [ "$diff" -lt 900 ]
            then
                notify=$(echo $line | sed "s/$ex_time //g")
                dunstify -a "Notes" "$notify" -u "critical" -t 45000
            fi
        done <<< "$sorted"
        sleep 5s
    done

  '';
in

{
  home.packages = with pkgs; [
    rofi_todo
    dunst_todo
  ];
}
