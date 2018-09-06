#!/bin/bash

workspace(){
	SPACE_NUM=$(xdotool get_desktop);
		case "$SPACE_NUM" in
			"0")
				WORKSPACE="%{B#FF3399FF}#%{B#FFEEEEEE} # #";;
			"1")
				WORKSPACE="# %{B#FF3399FF}#%{B#FFEEEEEE} #";;
			"2")
				WORKSPACE="# # %{B#FF3399FF}#%{B#FFEEEEEE}";;
		esac
	echo $WORKSPACE
}

clock(){
	echo -n $(date "+%R")
	echo -n " | "
	echo -n $(date "+%D")
	echo -n " "
}

music(){
	echo -n " "
	echo -n $(ncmpcpp --current-song)
}

gradd(){
	echo -n "%{B#FF3399FF} "
	echo -n "%{B#FF66AAFF} "
	echo -n "%{B#FF99CCFF} "
	echo -n "%{B#FFBBDDFF} "
	echo -n "%{B#FFEEEEEE} "
}

gradu(){
	echo -n "%{B#FFEEEEEE} "
	echo -n "%{B#FFBBDDFF} "
	echo -n "%{B#FF99CCFF} "
	echo -n "%{B#FF66AAFF} "
	echo -n "%{B#FF3399FF} "
}

while :; do
	echo "%{S1}%{B#FF3399FF}%{l}$(gradd)$(music)%{c}$(workspace)%{r}$(gradu)$(clock)%{B#FFEEEEEE}"
	sleep 0
done
