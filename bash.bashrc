clear
# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
#PS1='\[\e[0;32m\]\w\[\e[0m\] \[\e[0;97m\]\$\[\e[0m\] '

#if [ $(id -u) -eq 0 ];
#then # you are root, set red colour prompt
#  PS1="\\[$(tput setaf 3)\\]\\u@\\h:\\w # \\[$(tput sgr0)\\]"
#else # normal
#  PS1="[\\u@\\h:\\w] $"
#fi

# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi
neofetch --ascii_distro arch_small

GREY="\[\e[48;5;240m\]\[\e[38;5;250m\]"
GREY_END="\[\e[48;5;2m\]\[\e[38;5;240m\]"

GREEN="\[\e[48;5;2m\]\[\e[38;5;255m\]"
GREEN_END="\[\e[48;5;27m\]\[\e[38;5;2m\]"

ORANGE="\[\e[48;5;208m\]\[\e[38;5;255m\]"
ORANGE_END="\[\e[48;5;236m\]\[\e[38;5;208m\]"
ORANGE_RET_END="\[\e[48;5;160m\]\[\e[38;5;208m\]" # when next segment is prompt with return code

BLUE="\[\e[48;5;27m\]\[\e[38;5;255m\]"
BLUE_END="\[\e[48;5;208m\]\[\e[38;5;27m\]"           # when next segment is git
BLUE_END_JOBS="\[\e[48;5;93m\]\[\e[38;5;27m\]"       # when next segment is jobs
BLUE_END_ALT="\[\e[48;5;236m\]\[\e[38;5;27m\]"       # when next segment is prompt
BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]"       # when next segment is prompt with return code

JOBS="\[\e[48;5;93m\]\[\e[38;5;255m\] ⏎"
JOBS_END="\[\e[48;5;236m\]\[\e[38;5;93m\]"           # when next segment is prompt
JOBS_NO_RET_END="\[\e[48;5;208m\]\[\e[38;5;93m\]"    # when next segment is git
JOBS_NO_GIT_END="\[\e[48;5;160m\]\[\e[38;5;93m\]"    # when next segment is prompt with return code

RET="\[\e[48;5;160m\]\[\e[38;5;255m\]"
RET_END="\[\e[0m\]\[\e[38;5;160m\]\[\e[0m\] "

PROMPT="\[\e[48;5;236m\]\[\e[38;5;255m\]"
PROMPT_END="\[\e[0m\]\[\e[38;5;236m\]\[\e[0m\] "

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
PS1="$GREY \t $GREY_END$GREEN @\h $GREEN_END$BLUE \W \$(git_prompt) $BLUE_END_ALT$PROMPT \$ $PROMPT_END"
#PS1="\[\033[33m\]\u\[\033[00m\] \w \$(git_prompt)\[\033[00m\] \$ "

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(grep -E '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(grep -E '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(grep -E '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    output="${output}"$(git_status_behind)
    [[ -n $output ]] && output="$output"  # separate from branch name
    echo $output
}

git_status_behind() {
    # - behind
    local status="$(git status 2>/dev/null)"
    local output=''
    [[ $status =~ "behind" ]] && output="-"

    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;34m' # bold blue
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        if [[ -n $state ]]; then
            echo -e "\x01$color\x02[$branch $state]\x01\033[00m\x02"  # last bit resets color
        else
            echo -e "\x01$color\x02[$branch]\x01\033[00m\x02"  # last bit resets color
        fi
    fi
}
