#!/bin/bash

declare -a ports=("20" "21" "22" "23" "25" "42" "43" "49" "53" "67" "68" "69" "70" "80" "88" "123" "135" "137" "139" "143" "161" "162" "389" "443" "445" "464" "513" "587" "636" "1080" "1194" "993" "995" "1025" "1194" "1725" "1812" "1813" "3124" "3128" "5060" "5900" "6665" "6666" "6667" "6668" "6669" "6679" "6697" "8080")
_SETUP_PORTS=False
_TEST_PORTS=False

while getopts "i:st" opt; do
  case $opt in
    i)
      HOST=${OPTARG}
      echo "Testing ports on host ${HOST}" >&2
      ;;
    s)
      _SETUP_PORTS=True
      echo "Setting up listening ports" >&2
      ;;
    t)
      _TEST_PORTS=True
      echo "Testing ports on host ${HOST}" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

function result {
    RESULT=$1
    PORT=$2
    case $RESULT in
        0)
            echo "The access to $PORT was successful"
            ;;
        1)
            echo "The access to $PORT failed"
            exit 1
            ;;
        *)
            echo "Unknown exit error for the $PORT command. Exiting script."
            exit
            ;;
    esac
}

function test_ports {
    for port in "${ports[@]}"; do
        test_port=$(nc -z ${HOST} ${port})
        rc=$?
        result $rc port_${port}
    done
}

function start_ports {
    for port in "${ports[@]}"; do
        nc -lk ${port} &
    done
}

if [ ${_SETUP_PORTS} = True ]; then
    start_ports
elif [ ${_TEST_PORTS} = True ]; then
    test_ports
fi
