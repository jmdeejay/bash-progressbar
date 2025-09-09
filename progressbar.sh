#!/usr/bin/env bash

PB_PREFIX='Progress: '
PB_START_CHAR='['
PB_BAR_CHAR='#'
PB_EMPTY_CHAR='.'
PB_END_CHAR=']'

pb_init_term() {
	printf '\n'    # Add space for the scrollbar
	printf '\e7'   # Save the cursor location
	printf '\e[%d;%dr' 0 "$((LINES - 1))" # Set the scrollable region (margin)
	printf '\e8'   # Restore the cursor location
	printf '\e[1A' # Move cursor up
}

pb_restore_term() {
	printf '\e7'   # Save the cursor location
	printf '\e[%d;%dr' 0 "$LINES" # Reset the scrollable region (margin)
	printf '\e[%d;%dH' "$LINES" 0 # Move cursor to the bottom line
	printf '\e[2K' # Clear the line
	printf '\e8'   # Restore the cursor location
}

pb_init() {
	shopt -s checkwinsize
	# Ensure LINES and COLUMNS are set
	(:)

	trap pb_destroy exit
	trap pb_init_term winch
	pb_init_term
}

pb_destroy() {
	pb_restore_term
}

pb_update() {
	local progress=$1
	local total=$2

	local percentage_done=$((progress * 100 / total))
	local prefix="$PB_PREFIX[$percentage_done%]"
	local length=$((COLUMNS - ${#prefix} - 3))  # 3 accounts for PB_START_CHAR, PB_END_CHAR & 1 space between the prefix and the progressbar
	local num_bars=$((percentage_done * length / 100))

	local bar="$PB_START_CHAR"
	bar+=$(printf "%*s" "$num_bars" '' | tr ' ' "$PB_BAR_CHAR")
	bar+=$(printf "%*s" "$((length - num_bars))" '' | tr ' ' "$PB_EMPTY_CHAR")
	bar+="$PB_END_CHAR"

	printf '\e7'   # Save the cursor location
	printf '\e[%d;%dH' "$LINES" 0 # Move cursor to the bottom line
	printf '\e[2K' # Clear the line
	printf "\e[30;42m%s\e[0m %b" "$prefix" "$bar" # Print the progress bar
	printf '\e8'   # Restore the cursor location
}
