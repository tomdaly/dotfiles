#!/bin/bash

workspace(){
	SPACE_NUM=$(bspc query -D -d);
		case "$SPACE_NUM" in
			"1")
				WORKSPACE="%{B#FF3399FF}#%{B#FFEEEEEE} # # # #";;
			"2")
				WORKSPACE="# %{B#FF3399FF}#%{B#FFEEEEEE} # # #";;
			"3")
				WORKSPACE="# # %{B#FF3399FF}#%{B#FFEEEEEE} # #";;
			"4")
				WORKSPACE="# # # %{B#FF3399FF}#%{B#FFEEEEEE} #";;
			"5")
				WORKSPACE="# # # # %{B#FF3399FF}#%{B#FFEEEEEE}";;
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
	echo -n $(ncmpcpp --now-playing)
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
	echo "%{B#FF3399FF}%{l}$(music)$(gradd) %{c}$(workspace) %{r}$(gradu)$(clock)%{B#FFEEEEEE}"
	sleep 0
done
