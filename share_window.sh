#!/bin/bash

#
# Modified TMUX start script from:
#     http://forums.gentoo.org/viewtopic-t-836006-start-0.html
#
# Store it to `~/bin/tmx` and issue `chmod +x`.
#

# Works because bash automatically trims by assigning to variables and by 
# passing arguments

fengyu_tmux='/disk3/fengyu/install/bin/tmux -f ~/.tmux.conf'
trim() { echo $1; }

if [[ -z "$1" ]]; then
    echo "Specify session name as the first argument"
    exit
fi


# Only because I often issue `ls` to this script by accident
if [[ "$1" == "ls" ]]; then
    $fengyu_tmux ls
    exit
fi

base_session="$1"
# This actually works without the trim() on all systems except OSX
tmux_nb=$(trim `$fengyu_tmux ls | grep "^$base_session" | wc -l`)
if [[ "$tmux_nb" == "0" ]]; then
    echo "Launching tmux base session $base_session ..."
    eval "$fengyu_tmux new-session -s $base_session"
else
    # Make sure we are not already in a tmux session
    if [[ -z "$TMUX" ]]; then
        # Kill defunct sessions first
        old_sessions=$($fengyu_tmux ls 2>/dev/null | egrep "^[0-9]{14}.*[0-9]+\)$" | cut -f 1 -d:)
        for old_session_id in $old_sessions; do
            eval "$fengyu_tmux kill-session -t $old_session_id"
        done

        echo "Launching copy of base session $base_session ..."
        # Session is is date and time to prevent conflict
        session_id=`date +%Y%m%d%H%M%S`
        # Create a new session (without attaching it) and link to base session 
        # to share windows
        eval "$fengyu_tmux new-session -d -t $base_session -s $session_id"
        # Create a new window in that session
        #tmux new-window
        # Attach to the new session
        eval "$fengyu_tmux attach-session -t $session_id"
        # When we detach from it, kill the session
        eval "$fengyu_tmux kill-session -t $session_id"
    fi
fi