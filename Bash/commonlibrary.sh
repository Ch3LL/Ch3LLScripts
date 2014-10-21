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

