# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# some more ls alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add by Vinh Huynh to modify bash shell prompt
source ~/.config/git-url-swizzler/git-completion.bash
source ~/.config/git-url-swizzler/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

# Modify bash shell prompt
#
# Define the prompt_git function for git repository status
prompt_git() {
    local git_status=''
    local branchName=''

    # Check if the current directory is in a Git repository.
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the status summary.
        local gitSummary=$(git status --porcelain)

        # Check for uncommitted changes in the index, unstaged changes, untracked files, and stashed files.
        [[ -n $(echo "$gitSummary" | grep '^M') ]] && git_status+='+'
        [[ -n $(echo "$gitSummary" | grep '^ M') ]] && git_status+='!'
        [[ -n $(echo "$gitSummary" | grep '^\?\?') ]] && git_status+='?'
        [[ $(
            git rev-parse --verify refs/stash &>/dev/null
            echo "${?}"
        ) == '0' ]] && git_status+='$'

        # Get the short symbolic ref or the short SHA for the latest commit.
        branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo '(unknown)')"

        [ -n "${git_status}" ] && git_status=" [${git_status}]"

        printf "%b on %b%s%s" "${white}" "${blue}" "${branchName}" "${git_status}"
    else
        return
    fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
prompt_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Extract the last directory name in the $VIRTUAL_ENV path
        venv_name=$(basename "$VIRTUAL_ENV")
        printf "\n%b(%s)\n" "${steel_blue}" "${venv_name}"
    fi
}

# Using tput for colors and formatting.
tput sgr0 # reset colors
bold=$(tput bold)
reset=$(tput sgr0)
blue=$(tput setaf 153)
steel_blue=$(tput setaf 67)
green=$(tput setaf 71)
orange=$(tput setaf 166)
red=$(tput setaf 167)
white=$(tput setaf 15)
yellow=$(tput setaf 228)

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    userStyle="${red}"
else
    userStyle="${orange}"
fi

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}"
else
    hostStyle="${yellow}"
fi

PS1="\$(prompt_venv)"              # virtual environment
PS1+="\[${bold}\]\n"               # newline
PS1+="\[${userStyle}\]\u"          # username
PS1+="\[${white}\]@"
PS1+="\[${hostStyle}\]\h"          # host
PS1+="\[${white}\] in "
PS1+="\[${green}\]\W"              # working directory
PS1+="\$(prompt_git)"              # Git repository details
PS1+="\n"
PS1+="\[${white}\]\$ \[${reset}\]" # `$` (and reset color)
export PS1

PS2="\[${yellow}\]→ \[${reset}\]"
export PS2

# setup config for neovim
export XDG_CONFIG_HOME=/home/$USER/.config
export XDG_DATA_HOME=/home/$USER/.local/share
alias nvim=/home/$USER/.local/bin/nvim
