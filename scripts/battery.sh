#!/bin/bash
battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
percentage_re="percentage:\s+([0-9]*)%"
state_re="state:\s+(\S+)"
if [[ $battery_info =~ $percentage_re ]]
then
    percentage="${BASH_REMATCH[1]}"
fi
if [[ $battery_info =~ $state_re ]]
then
    state="${BASH_REMATCH[1]}"
fi

[ -z "$percentage" ] && exit 1
[ -z "$state" ] && exit 1

fg=colour15
charg_char=""
if [ $percentage -lt 20 ]; then
  if [ $state == "charging" ]; then
    bg=colour202
  else
    bg=colour160
  fi
else
  bg=colour2
fi
if [ $state == "charging" ]; then
    charg_char="⚡"
fi

echo "#[fg=${bg}]◀#[fg=${fg},bg=${bg}] "$percentage"%"$charg_char

