# ===============================================
# RedVortex XP System v1.1
# Author  : Shubham Gautam (RedVortex)
# GitHub  : https://github.com/anonymous777999
# Linkdin : https://www.linkedin.com/in/shubham-gautam-225187218/
# ===============================================
#!/bin/bash

# ─────────────[ GLOBAL FILE PATHS ]─────────────
XP_FILE="$HOME/.redvortex_xp"
LVL_FILE="$HOME/.redvortex_lvl"
LOG_FILE="$HOME/.redvortex_daily_log"
QUEST_FILE="$HOME/.redvortex_quests"
ROADMAP_FILE="$HOME/.redvortex_roadmap"
PHASE_FILE="$HOME/.redvortex_phase"

# ─────────────[ MAIN CONTROL PANEL ]─────────────
RedVortex_ControlPanel() {
    clear
    [ ! -f "$XP_FILE" ] && echo 0 > "$XP_FILE"
    [ ! -f "$LVL_FILE" ] && echo 1 > "$LVL_FILE"
    [ ! -f "$PHASE_FILE" ] && echo 1 > "$PHASE_FILE"

    XP=$(<"$XP_FILE")
    LVL=$(<"$LVL_FILE")
    RANK=$(get_rank $LVL)
    NEXT_LVL_XP=$(get_next_level_xp $LVL)
    PERCENT=$((XP * 100 / NEXT_LVL_XP))
    [ "$PERCENT" -gt 100 ] && PERCENT=100
    FILLED=$((PERCENT / 5))
    EMPTY=$((20 - FILLED))
    BAR=$(printf "%0.s█" $(seq 1 $FILLED))
    BAR+=$(printf "%0.s░" $(seq 1 $EMPTY))

    echo -e "\e[1;36m┌────────────────────────────────────────┐"
    echo -e "│      🚀 RedVortex Hacker Control Panel │"
    echo -e "├────────────────────────────────────────┤"
    echo -e "│ 🧠 Level        : $LVL"
    echo -e "│ 🔋 XP           : $XP / $NEXT_LVL_XP XP"
    echo -e "│ 📶 Progress     : [\e[32m$BAR\e[0m] $PERCENT%"
    echo -e "│ 🏆 Rank         : $RANK"
    echo -e "│ 📚 Skill        : $(get_skill $LVL)"
    echo -e "├────────────────────────────────────────┤"
    echo -e "│ 🎯 Menu:"
    echo -e "│   [1] Add XP"
    echo -e "│   [2] View Skillbook 📔"
    echo -e "│   [3] Show Rank Progress 📈"
    echo -e "│   [4] Daily XP Summary"
    echo -e "│   [5] Lifetime Stats"
    echo -e "│   [6] Streak Tracker 🔥"
    echo -e "│   [7] Add Quest 🧩"
    echo -e "│   [8] Manage Quests 📜"
    echo -e "│   [9] Generate Daily Quest 🎯"
    echo -e "│   [10] Add Quest Manually 🛠"
    echo -e "|   [11] Check how to get more XP"
    echo -e "│   [12] Exit"
    echo -e "└────────────────────────────────────────┘\e[0m"

    read -p "Enter your choice [1-12]: " choice
    case $choice in
        1) add_xp ;;
        2) view_skillbook ;;
        3) show_rank_progress ;;
        4) daily_xp_summary ;;
        5) view_lifetime_stats ;;
        6) show_streak ;;
        7) add_quest ;;
        8) manage_quests ;;
        9) generate_daily_quest ;;
        10) manual_add_roadmap_entry ;;
	11) check_xp_tasks ;;
        12) echo -e "\e[33mGoodbye RedVortex. Return stronger.\e[0m"; exit ;;
        *) echo -e "\e[31mInvalid choice. Try again.\e[0m"; sleep 1; RedVortex_ControlPanel ;;
    esac
}

add_xp() {
    read -p "Enter XP to add: " newxp
    if ! [[ "$newxp" =~ ^[0-9]+$ ]]; then
        echo -e "\e[31m❌ Invalid input. Please enter a number.\e[0m"
        sleep 1
        RedVortex_ControlPanel
        return
    fi
    XP=$(<"$XP_FILE")
    XP=$((XP + newxp))
    echo "$XP" > "$XP_FILE"
    echo "$(date +%F)+$newxp" >> "$LOG_FILE"
    echo -e "\e[32m[+XP] You gained $newxp XP!\e[0m"
    check_level
    sleep 1
    RedVortex_ControlPanel
}

view_skillbook() {
    echo -e "\n\e[1;36m🧠 RedVortex Skillbook\e[0m\n───────────────────────────────"
    LVL=$(<"$LVL_FILE")
    for i in {1..10}; do
        skill=$(get_skill $i)
        rank=$(get_rank $i)
        if [ "$i" -le "$LVL" ]; then
            echo -e "✅ Level $i – $rank → Skill: $skill"
        else
            echo -e "🔒 Level $i – ??? → Unlocks at Level $i"
        fi
    done
    read -p "Press Enter to return..." dummy && RedVortex_ControlPanel
}

get_rank() {
    case $1 in
        1) echo "Script Kid" ;;
        2) echo "Packet Whisperer" ;;
        3) echo "File Invader" ;;
        4) echo "Service Manipulator" ;;
        5) echo "Rootwalker" ;;
        6) echo "Payload Crafter" ;;
        7) echo "Web Slayer" ;;
        8) echo "Memory Bender" ;;
        9) echo "Zero-Day Seeker" ;;
        10) echo "Digital God 👑" ;;
        *) echo "Unknown" ;;
    esac
}

get_skill() {
    case $1 in
        1) echo "Bash Basics" ;;
        2) echo "Network Recon" ;;
        3) echo "File Permissions" ;;
        4) echo "System Services" ;;
        5) echo "Priv Escalation" ;;
        6) echo "Payload Creation" ;;
        7) echo "Web & API Attacks" ;;
        8) echo "Exploit Dev" ;;
        9) echo "0-Day Research" ;;
        10) echo "Root Everything" ;;
        *) echo "Unknown" ;;
    esac
}

get_next_level_xp() {
    case $1 in
        1) echo 9000 ;;
        2) echo 30000 ;;
        3) echo 70000 ;;
        4) echo 12000 ;;
        5) echo 200000 ;;
        6) echo 300000 ;;
        7) echo 450000 ;;
        8) echo 600000 ;;
        9) echo 800000 ;;
        *) echo 9999999 ;;
    esac
}

check_level() {
    XP=$(<"$XP_FILE")
    LVL=$(<"$LVL_FILE")
    NEXT_LVL_XP=$(get_next_level_xp $LVL)
    if [ "$XP" -ge "$NEXT_LVL_XP" ]; then
        NEW_LVL=$((LVL + 1))
        echo "$NEW_LVL" > "$LVL_FILE"
        echo -e "\e[35m💥 LEVEL UP! Now Level $NEW_LVL – $(get_rank $NEW_LVL)\e[0m"
    fi
}

show_rank_progress() {
    XP=$(<"$XP_FILE")
    LVL=$(<"$LVL_FILE")
    NEXT=$(get_next_level_xp $LVL)
    PERCENT=$((XP * 100 / NEXT))
    [ "$PERCENT" -gt 100 ] && PERCENT=100
    FILLED=$((PERCENT / 5))
    EMPTY=$((20 - FILLED))
    BAR=$(printf "%0.s█" $(seq 1 $FILLED))
    BAR+=$(printf "%0.s░" $(seq 1 $EMPTY))
    echo -e "\n\e[1;36m🚧 Progress: Level $LVL → $(get_rank $LVL)\e[0m"
    echo -e "XP: $XP / $NEXT ($PERCENT%)"
    echo -e "Progress: [\e[32m$BAR\e[0m]"
    read -p "Press Enter to return..." dummy && RedVortex_ControlPanel
}

daily_xp_summary() {
    [ ! -f "$LOG_FILE" ] && echo -e "\e[33mNo XP log yet.\e[0m" && sleep 1 && RedVortex_ControlPanel
    echo -e "\n\e[1;36m📅 Daily XP Summary:\e[0m\n───────────────────────────────"
    cut -d'+' -f1 "$LOG_FILE" | sort | uniq | while read day; do
        total=$(grep "$day" "$LOG_FILE" | cut -d'+' -f2 | paste -sd+ | bc)
        mark="🔥"; [ "$total" -lt 100 ] && mark="⚠"
        echo -e "$day → +$total XP   $mark"
    done
    read -p "Press Enter to return..." dummy && RedVortex_ControlPanel
}

view_lifetime_stats() {
    XP=$(<"$XP_FILE")
    LVL=$(<"$LVL_FILE")
    NEXT=$(get_next_level_xp $LVL)
    FIRST=$(head -n 1 "$LOG_FILE" 2>/dev/null | cut -d'+' -f1)
    ACTIVE_DAYS=$(cut -d'+' -f1 "$LOG_FILE" 2>/dev/null | sort -u | wc -l)
    PERCENT=$((XP * 100 / NEXT))
    [ "$PERCENT" -gt 100 ] && PERCENT=100
    FILLED=$((PERCENT / 5))
    EMPTY=$((20 - FILLED))
    BAR=$(printf "%0.s█" $(seq 1 $FILLED))
    BAR+=$(printf "%0.s░" $(seq 1 $EMPTY))
    echo -e "\n\e[1;35m📊 Lifetime Stats\e[0m\n───────────────────────────────"
    echo -e "🧠 Level         : $LVL"
    echo -e "🔋 Total XP      : $XP"
    echo -e "🎯 XP to Next    : $((NEXT - XP))"
    echo -e "📆 Active Days   : $ACTIVE_DAYS"
    echo -e "🚀 Started On    : ${FIRST:-Unknown}"
    echo -e "📶 Progress      : [\e[32m$BAR\e[0m] $PERCENT%"
    read -p "Press Enter to return..." dummy && RedVortex_ControlPanel
}

show_streak() {
    [ ! -f "$LOG_FILE" ] && echo -e "\e[33mNo XP log yet.\e[0m" && sleep 1 && RedVortex_ControlPanel
    DAYS=($(cut -d'+' -f1 "$LOG_FILE" | sort -u))
    MAX=1; STREAK=1
    for ((i=1; i<${#DAYS[@]}; i++)); do
        d1=$(date -d "${DAYS[$i-1]}" +%s)
        d2=$(date -d "${DAYS[$i]}" +%s)
        [[ $(( (d2-d1)/86400 )) -eq 1 ]] && ((STREAK++)) || STREAK=1
        [[ $STREAK -gt $MAX ]] && MAX=$STREAK
    done
    LAST=${DAYS[-1]}
    TODAY=$(date +%F)
    YESTERDAY=$(date -d "yesterday" +%F)
    CURR=$([[ "$LAST" == "$TODAY" || "$LAST" == "$YESTERDAY" ]] && echo "$STREAK" || echo "0")
    echo -e "\n🔥 Last Active : $LAST"
    echo -e "🔥 Current     : $CURR Days"
    echo -e "🏅 Longest     : $MAX Days"
    [ "$CURR" -eq 0 ] && echo -e "\e[31m⚠  You broke your streak!\e[0m"
    read -p "Press Enter to return..." dummy && RedVortex_ControlPanel
}

add_quest() {
    echo -e "\n🧩 Add a New Quest"
    read -p "Quest Description: " desc
    read -p "XP Reward: " reward
    echo "$desc+$reward+pending" >> "$QUEST_FILE"
    echo -e "\e[32m✅ Quest Added!\e[0m"
    sleep 1 && RedVortex_ControlPanel
}

manage_quests() {
    [ ! -f "$QUEST_FILE" ] && echo -e "\e[33mNo quests yet.\e[0m" && sleep 1 && RedVortex_ControlPanel
    echo -e "\n📜 Quest Log\n───────────────────────────────"
    mapfile -t QUESTS < "$QUEST_FILE"
    for i in "${!QUESTS[@]}"; do
        IFS='+' read -r desc xp status <<< "${QUESTS[$i]}"
        echo "[$((i+1))] $desc – $xp XP – Status: $status"
    done
    echo -e "───────────────────────────────"
    read -p "Mark quest # as complete (or Enter to skip): " num
    [[ -z "$num" ]] && RedVortex_ControlPanel
    ((index = num - 1))
    IFS='+' read -r desc xp status <<< "${QUESTS[$index]}"
    [[ "$status" == "done" ]] && echo -e "\e[33mAlready completed.\e[0m" && sleep 1 && RedVortex_ControlPanel
    echo -e "\e[32m🎉 Completed: $desc +$xp XP!\e[0m"
    XP=$(<"$XP_FILE")
    xp=$(echo "$xp" | xargs)
    XP=$((XP + xp))
    echo "$XP" > "$XP_FILE"
    echo "$(date +%F)+$xp" >> "$LOG_FILE"
    QUESTS[$index]="$desc+$xp+done"
    printf "%s\n" "${QUESTS[@]}" > "$QUEST_FILE"
    check_level
    sleep 1 && RedVortex_ControlPanel
}
generate_daily_quest() {
    [ ! -f "$PHASE_FILE" ] && echo 1 > "$PHASE_FILE"
    [ ! -f "$ROADMAP_FILE" ] && touch "$ROADMAP_FILE"

    current_phase=$(cat "$PHASE_FILE")

    mapfile -t lines < <(awk -v phase="[Phase $current_phase]" '
        index($0, phase) { show=1; next }
        /^\[Phase/ { show=0 }
        show && NF > 0
    ' "$ROADMAP_FILE")

    if [ ${#lines[@]} -eq 0 ]; then
        echo -e "\e[31mNo topics found for Phase $current_phase in roadmap.\e[0m"
        sleep 2 && RedVortex_ControlPanel
        return
    fi

    rand_index=$((RANDOM % ${#lines[@]}))
    quest_line="${lines[$rand_index]}"

    topic=$(echo "$quest_line" | awk -F ' - ' '{print $1}')
    duration=$(echo "$quest_line" | awk -F ' - ' '{print $2}')

    if [[ -z "$topic" || -z "$duration" ]]; then
        echo -e "\e[31m❌ Quest parsing failed. Please check your roadmap format.\e[0m"
        sleep 2 && RedVortex_ControlPanel
        return
    fi

    clear
    echo -e "\n\e[1;35m📌 RedVortex Daily Quest Generator\e[0m"
    echo -e "────────────────────────────────────────"
    echo -e "🧠 Phase         : $current_phase"
    echo -e "🎯 Today's Task  : $topic"
    echo -e "⏱  Estimated Time : $duration"
    echo -e "🔥 Tip           : Complete this to earn XP or mark quest manually!"
    echo -e "────────────────────────────────────────"
    read -p "Press Enter to return to Control Panel..." && RedVortex_ControlPanel
}


manual_add_roadmap_entry() {
    [ ! -f "$PHASE_FILE" ] && echo 1 > "$PHASE_FILE"
    [ ! -f "$ROADMAP_FILE" ] && touch "$ROADMAP_FILE"

    current_phase=$(cat "$PHASE_FILE")
    phase_tag="[Phase $current_phase]"

    grep -q "$phase_tag" "$ROADMAP_FILE" || echo -e "\n$phase_tag" >> "$ROADMAP_FILE"

    echo -e "\n🛠  Add a Topic to Phase $current_phase"
    read -p "Topic Name        : " topic
    read -p "Estimated Duration (e.g. 2 days): " duration

    echo "$topic - $duration - [🎯 Suitable for Daily Quest]" >> "$ROADMAP_FILE"
    echo -e "\e[32m✅ Added to Phase $current_phase:\e[0m $topic ($duration)"
    sleep 1.5 && RedVortex_ControlPanel
}

# Save this function in your ~/.bashrc or run it directly in terminal

check_xp_tasks() {
  echo "🔥 RedVortex Daily XP Tracker 🔥"
  local total_xp=0

  # Helper to ask Y/N and add XP if yes
  ask_task() {
    local task_desc="$1"
    local xp_value=$2
    read -rp "$task_desc (y/n)? " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
      echo " +$xp_value XP"
      total_xp=$((total_xp + xp_value))
    else
      echo " +0 XP"
    fi
  }

  echo "Answer the following tasks honestly:"

  ask_task "Did you do focused deep learning & hands-on labs today?" 300
  ask_task "Did you build or improve any hacking tool or script today?" 300
  ask_task "Did you mentor, answer questions, or lead in communities today?" 200
  ask_task "Did you hunt bugs or participate in bug bounty programs today?" 400
  ask_task "Did you do any freelance pentesting or consulting work today?" 150
  ask_task "Did you create or share any content (blog, video, podcast) today?" 200
  ask_task "Did you work on defense, protection, or privacy tasks today?" 150
  ask_task "Did you complete any CTF or boss fight challenges today?" 250

  echo "------------------------------------"
  echo "Total XP earned today: $total_xp XP"
  if (( total_xp >= 1500 )); then
    echo "🔥 Epic grind day! Keep it up, Shadow Monarch!"
  elif (( total_xp >= 800 )); then
    echo "💪 Solid work, keep pushing."
  else
    echo "⚡️ Keep the momentum, level up tomorrow!"
  fi
  echo "Press Enter to Return to Control pannel...." && RedVortex_ControlPanel
}


# ─────────────[ START ]─────────────
RedVortex_ControlPanel

