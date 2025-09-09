# Bash Progress Bar Utility
A simple, reusable progress bar library for Bash scripts. \
It lets you display a clean progress indicator at the bottom of your terminal while running loops, tasks, or file processing.

## Features

- Easy to include in any script with source progressbar.sh
- Displays progress as a colored bar at the bottom of the terminal
- Works with custom totals and current progress values
- No dependencies (pure Bash + ANSI escape sequences)
- Configurable bar characters and colors


## Installation

Just copy progressbar.sh somewhere accessible, then include it in your scripts:
``` bash
source /path/to/progressbar.sh
```


## Usage

``` bash
#!/usr/bin/env bash
source ./progressbar.sh

local total=20
pb_init  # Initialize progress bar

for ((i = 1; i <= total; i++)); do
	pb_update "$i" "$total" # Update progress bar
    sleep 0.1
done
```

### Output
``` bash
Progress: [50%] [####################....................]
```


## API

### pb_init

Initializes the progress bar. \
Call this once before starting updates.

### pb_destroy (optional)

Destroys the progress bar and restores the terminal to its normal state. \
Normally, this is called automatically at the end of your script. \
You can call it manually if you want to stop displaying the progress bar before your script finishes.

### pb_update <current> <total>

Updates the progress bar. \
The bar will refresh in-place at the bottom of the terminal. \

current → current step or item number \
total → total number of steps/items


## Configuration

You can customize the bar characters and colors by setting these variables before calling pb_update:

``` bash
PB_PREFIX='Progress: '
PB_START_CHAR='['
PB_BAR_CHAR="#"
PB_EMPTY_CHAR="."
PB_END_CHAR=']'
```

## Notes

Designed for Linux/macOS terminals with ANSI support


## License

MIT — free to use, modify, and distribute.
