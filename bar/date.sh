#!/bin/bash

dat(){
	echo -n $(date "+%R")
	echo -n " | "
	echo -n $(date "+%D")
}

while :; do
	echo "%{r}$(dat)"
	sleep 1
done
