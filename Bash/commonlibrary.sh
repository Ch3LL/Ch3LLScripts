#!/bin/bash

function continue {

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
			continue
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

