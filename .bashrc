# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific content starts
export PATH=/global/share/opt/bin:/home/fengyu/tools/netperf-install/bin:/disk3/fengyu/install/bin/:$PATH
export HADOOP_INSTALL=/disk3/fengyu/dev/hadoop-install
# User specific aliases and functions
alias emax='emacs'
alias mux='/disk3/fengyu/install/bin/share_window.sh fengyu'
alias manp='man -M /disk3/fengyu/install/share/man/'
alias mypy='/disk1/fengyu/misc/python/env/bin/python'
