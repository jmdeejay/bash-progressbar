#!/usr/bin/env bash

. progressbar.sh

process_item() {
    local index=$1
    echo "Processing item $index"
    sleep 0.05
}

main() {
    local total=100
    echo "Processing $total items..."

    pb_init
    for ((progress = 0; progress < total; progress++)); do
        pb_update "$((progress + 1))" "$total"
        process_item "$((progress + 1))"
    done
    echo "All done!"
}

main "$@"
