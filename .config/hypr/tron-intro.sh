#!/bin/bash

CYAN='\033[38;2;0;229;255m'
CYAN_DIM='\033[38;2;0;100;120m'
WHITE='\033[38;2;255;255;255m'
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

hide_cursor() { tput civis; }
show_cursor() { tput cnorm; }
clear_screen() { tput clear; }

trap 'show_cursor; echo -e "${RESET}"; exit' INT

hide_cursor
clear_screen

COLS=$(tput cols)

# --- GRID LINE ---
grid_line() {
    local line=""
    for ((i=0; i<COLS; i++)); do
        if (( RANDOM % 6 == 0 )); then line+="+"
        elif (( RANDOM % 4 == 0 )); then line+="-"
        else line+=" "; fi
    done
    echo -e "${CYAN_DIM}${line}${RESET}"
}

grid_line
echo ""

# --- BOOT SEQUENCE ---
boot_lines=(
    "ENCOM OS 12.4 :: SYSTEM BOOT"
    "Establishing secure connection....."
    "User identity confirmed............"
)

for line in "${boot_lines[@]}"; do
    echo -e "${CYAN_DIM}  > ${CYAN}${line}  ${CYAN_DIM}[${CYAN}OK${CYAN_DIM}]${RESET}"
    sleep 0.05
done

echo ""

# --- DIVIDER ---
divider=""
for ((i=0; i<COLS; i++)); do divider+="-"; done
echo -e "${CYAN_DIM}${divider}${RESET}"
echo ""

# --- TRON LOGO LINES ---
logo=(
"  ████████╗██████╗  ██████╗ ███╗   ██╗"
"     ██╔══╝██╔══██╗██╔═══██╗████╗  ██║"
"     ██║   ██████╔╝██║   ██║██╔██╗ ██║"
"     ██║   ██╔══██╗██║   ██║██║╚██╗██║"
"     ██║   ██║  ██║╚██████╔╝██║ ╚████║"
"     ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
)

pad=$(( (COLS - 40) / 2 ))

# PHASE 1: scanline dim
for line in "${logo[@]}"; do
    printf "%${pad}s"
    echo -e "${CYAN_DIM}${DIM}${line}${RESET}"
    sleep 0.04
done

# PHASE 2: flicker to normal cyan
sleep 0.1
tput cuu ${#logo[@]}
for line in "${logo[@]}"; do
    printf "%${pad}s"
    echo -e "${CYAN}${line}${RESET}"
    sleep 0.03
done

# PHASE 3: pulse to white
sleep 0.08
tput cuu ${#logo[@]}
for line in "${logo[@]}"; do
    printf "%${pad}s"
    echo -e "${WHITE}${BOLD}${line}${RESET}"
    sleep 0.02
done

# PHASE 4: settle to final cyan
sleep 0.08
tput cuu ${#logo[@]}
for line in "${logo[@]}"; do
    printf "%${pad}s"
    echo -e "${CYAN}${BOLD}${line}${RESET}"
    sleep 0.02
done

echo ""

# --- SUBTITLE ---
subtitle="[ THE GRID — END OF LINE ]"
pad2=$(( (COLS - ${#subtitle}) / 2 ))
printf "%${pad2}s"
echo -e "${CYAN_DIM}${subtitle}${RESET}"
echo ""

echo -e "${CYAN_DIM}${divider}${RESET}"
echo ""

# --- SYSTEM INFO ---
os=$(grep "^NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
kernel=$(uname -r)
host=$(cat /etc/hostname)
uptime=$(uptime -p | sed 's/up //')
cpu=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')
mem_total=$(grep MemTotal /proc/meminfo | awk '{printf "%.0f", $2/1024}')
mem_avail=$(grep MemAvailable /proc/meminfo | awk '{printf "%.0f", $2/1024}')
mem_used=$(( mem_total - mem_avail ))
disk=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
packages=$(pacman -Q | wc -l)
shell=$(echo $SHELL | xargs basename)

echo -e "${CYAN_DIM}  IDENTITY  ${CYAN}${USER}@${host}${RESET}"
echo -e "${CYAN_DIM}  OS        ${CYAN}${os}${RESET}"
echo -e "${CYAN_DIM}  KERNEL    ${CYAN}${kernel}${RESET}"
echo -e "${CYAN_DIM}  SHELL     ${CYAN}${shell}${RESET}"
echo -e "${CYAN_DIM}  CPU       ${CYAN}${cpu}${RESET}"
echo -e "${CYAN_DIM}  MEMORY    ${CYAN}${mem_used} MiB / ${mem_total} MiB${RESET}"
echo -e "${CYAN_DIM}  DISK      ${CYAN}${disk}${RESET}"
echo -e "${CYAN_DIM}  PACKAGES  ${CYAN}${packages} (pacman)${RESET}"
echo -e "${CYAN_DIM}  UPTIME    ${CYAN}${uptime}${RESET}"
echo ""

grid_line
echo ""

show_cursor
