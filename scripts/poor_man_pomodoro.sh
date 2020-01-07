#!/bin/sh
while true; do
    echo $(date +"%T") ": Starting 50m focus.."
    osascript -e 'display notification "50m focus started" with title "Pomodoro"'
    sleep 3000
    echo $(date +"%T") ": Starting 10m break.."
    osascript -e 'display notification "10m break started" with title "Pomodoro"'
    sleep 600
done
