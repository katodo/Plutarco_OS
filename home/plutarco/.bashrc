# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#####################################################################
# Extremely useful features to add to your Linux .bashrc file.
# Provides colored highlighting of the shell prompt based on whether a command returned an error or not. Plus a few handy colorizations of 'ls', 'grep', etc.
# Tested on Ubuntu, Debian and Arch. By Shervin Emami, 2014.

#######################################################################
# Get the BASH command prompt to show the hostname & time & path, in a distinct color from regular text,
# and shown in red if the previous command had an error.
# eg:   "john@mypc:1 12:04:58 /etc $"

# Text display colors for Ubuntu or Debian:
RESET='\[\e[0m\]'
RED_TEXT="${RESET}\[\e[7;3;31m\]"
RED_BOLD="${RESET}\[\e[1;41;39m\]"
BLUE_TEXT="${RESET}\[\e[0;44m\]"
BLUE_BOLD="${RESET}\[\e[1;44m\]"
GREEN_TEXT="${RESET}\[\e[0;30;42m\]"
GREEN_BOLD="${RESET}\[\e[1;42;39m\]"
YELLOW_TEXT="${RESET}\[\e[0;103;30m\]"
YELLOW_BOLD="${RESET}\[\e[1;103;30m\]"
PURPLE_TEXT="${RESET}\[\e[0;45;30m\]"
PURPLE_BOLD="${RESET}\[\e[1;45;97m\]"
GREY_TEXT="${RESET}\[\e[0;100;97m\]"
GREY_BOLD="${RESET}\[\e[1;100;97m\]"

# Choose one of the text colors: blue, green, yellow, purple or grey:
TEXT="$BLUE_TEXT"
BOLD="$BLUE_BOLD"
#TEXT="$GREEN_TEXT"
#BOLD="$GREEN_BOLD"
#TEXT="$YELLOW_TEXT"
#BOLD="$YELLOW_BOLD"
#TEXT="$PURPLE_TEXT"
#BOLD="$PURPLE_BOLD"
#TEXT="$GREY_TEXT"
#BOLD="$GREY_BOLD"

# If you want to display something different to the hostname, change it from \h:
HOST="\h"               # eg: "mango"
#HOST="\u@\h:\l"        # eg: "john@mango:1"

# Choose to end with either the full username, or just the $ or # symbol:
ENDING='\$'       # Single character (eg: "$" for users or "#" for root)

# The next 3 lines cause a red background if the previous command returned an error:
PS1_OK="${BOLD}${HOST} ${TEXT}\T ${BOLD}\w ${TEXT}"
PS1_ERROR="${RED_BOLD}${HOST} ${RED_TEXT}\T ${RED_BOLD}\w ${RED_TEXT}"
PS1="\$(if [[ \$? > 0 ]]; then echo -e '$PS1_ERROR'; else echo -e '$PS1_OK'; fi)${ENDING}${RESET} "



######################################################################
# Enable color support of ls and also add handy aliases:
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    COLOR='--color=auto'
fi

# Set ls parameters:
alias ls='ls -AFh --time-style=long-iso $COLOR'
# Create shortcuts for ls:
alias l='ls -o'     # Long list format (like "ls -l" but better)
alias lt='l -tr'    # Sorted by time & date (in reverse)
alias lS='l -Sr'    # Sorted by filesize (in reverse)
# Create shortcuts for grep:
alias grep='grep $COLOR --exclude-dir=.svn'
alias fgrep='fgrep $COLOR --exclude-dir=.svn'
alias egrep='egrep $COLOR --exclude-dir=.svn'


# Create my own 'psgrep' that is basically a "ps -ef | grep" to search running processes:
alias psgrep='ps -ef | grep -v grep | grep'
# Show lots of useful info about the attached disks & storage devices:
alias lsblkf='sudo lsblk -o MODEL,NAME,LABEL,FSTYPE,SIZE,MOUNTPOINT,UUID'
#####################################################################




source /opt/ros/jade/setup.bash
source ~/catkin_ws/devel/setup.bash
export ROS_HOSTNAME=plutarco.local
export ROS_MASTER_URI=http://plutarco.local:11311
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/max_xxv/catkin_ws/src
export ROS_IP=$(hostname -I)

