#!/bin/bash

declare -a ports=("4505" "4506")
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
            exit
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
    for port in ${ports}; do
        test_port=$(nc -lk ${port} &)
    done
}

if [ ${_SETUP_PORTS} = True ]; then
    start_ports
elif [ ${_TEST_PORTS} = True ]; then
    test_ports
fi
