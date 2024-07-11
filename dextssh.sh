#!bin/bash
if tmux has-session -t "0" 2>/dev/null; then
    session=0
else 
    tmux new-session -d -s "0"
fi
tmux send-keys -t 0 "/home/student/Downloads/B220032CS/scraping-twitter/extssh.sh" C-m
tmux attach-session -t 0
sleep 100000000000
