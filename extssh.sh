#!/bin/bash

THOME = /home/student
#THOME = /root
# Set the working directory
WORKING_DIR="/home/student/Downloads/B220032CS/tor-expert-bundle/tor"

# Function to check for the process and restart tor and autossh
check_and_restart() {
    cd $WORKING_DIR

    # Get the PID of the process running ./tor -f torrc
    tor_pid=$(ps aux | grep './tor -f torrc' | grep -v grep | awk '{print $2}')

    if [ ! -z "$tor_pid" ]; then
        # Kill the process
        kill -9 $tor_pid
        echo "Killed process ./tor -f torrc with PID $tor_pid"
    else
        echo "No ./tor -f torrc process found"
    fi

    # Restart the tor process and capture output to check for the bootstrapped message
    ./tor -f torrc > tor.log 2>&1 &
    tor_pid=$!
    echo "Restarted ./tor -f torrc with PID $tor_pid, waiting for bootstrapped message"

    # Monitor the log file for the bootstrapped message
    tail -f tor.log | while read LOGLINE
    do
        [[ "${LOGLINE}" == *"Bootstrapped 100% (done): Done"* ]] && pkill -P $$ tail
    done

    echo "Bootstrapped message found, starting autossh interactively"
    autossh test0-azvm
}

# Schedule the function to run every hour
while true; do
    THOME/.local/bin/nitc-fwd login
    check_and_restart
    sleep 3600  # Sleep for 1 hour
done

