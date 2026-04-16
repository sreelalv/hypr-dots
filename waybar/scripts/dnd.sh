#!/usr/bin/env bash

dnd(){
	local dnd_status=$(swaync-client -D) 
	if [[ $dnd_status == true ]]  ; then 
		echo '{ "text" : "", "class" : "dnd-on" }' 
	else
		echo '{ "class" : "dnd-off" }'
	fi
}

dnd
