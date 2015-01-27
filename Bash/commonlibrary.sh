#!/bin/bash

function forward {

	read -p "Do you want to continue? (y/n)" ANSWER
	case $ANSWER in
		y) 
			echo "Continuing"
			;;
		n)
			echo "Exiting"
			exit
			;;
		*)
			echo "Unknown option. Try again"
			forward
			exit
			;;
	esac
		

}

function result {
	
	RESULT=$?
	COMMAND=$1
	case $RESULT in
		0)
			echo "The $COMMAND command was successful"
			;;
		1)
			echo "The $COMMAND command failed"
			exit
			;;
		*)
			echo "Unknown exit error for the $COMMAND command. Exiting script."
			exit	
			;;
	esac
}

########
#COLORS#
#######
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

############################

