alias grepc='grep --color=auto'
alias ll='ls -lh'
alias l='ll'
alias lla='ll -a'
alias lsa='ls -a'
alias lsd='ll | grep "^d"'
alias lsf='ll | grep "^-"'
alias lsl='ll | grep "^l"'
alias lsps='ps aux | grep -i '
alias psgrep='lsps'
alias morup='more `$(history -p !!)`'
alias rmr='rm -r'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias free='free -m'
mkcd () { mkdir -p "$@" && cd "$@"; }

alias srcalias='. ~/.bashrc'
alias mkalias='sudo nano ~/.bash_aliases && srcalias'

alias sudo='sudo -sE PATH=$PATH'
alias fuck='sudo $(fc -ln -1)'

alias gita='git add -A . && git commit -m'

alias histgrep="history | grep "

# Brightpearl
alias sshfitnessehost='ssh brightpearl@fitnessehost'
alias sshservicecukevm='ssh ci@172.27.4.102'
alias findsnapshots='find ~/brightpearl-source/brightpearl-code/services/ -name "pom.xml" | xargs grep --color=auto "SNAPSHOT"'
alias rootvm='ssh root-vm'
alias devvm='ssh dev-vm'
alias dvm='devvm'
alias vmbox='ssh dev-box'
alias runtests='dvm "runtests"'
alias cdcode='cd /Users/al/brightpearl-source/brightpearl-code/brightpearl'
alias cdservices='cd /Users/al/brightpearl-source/brightpearl-code/services'
alias bs='buildservice'

function rbenv() {
  cd ~/
}


cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func

if [[ $BASH_VERSION > "2.05a" ]]; then
  # ctrl+w shows the menu
  bind -x "\"\C-w\":cd_func -- ;"
fi


function findinfiles() {
  if [ -z "$1" ]; then
    echo "No argument supplied"
    exit 1
  fi

  find . -type f -print0 2>/dev/null | xargs -0 grep --color=AUTO -Hn "$1" 2>/dev/null
}

export PS1="\[$(tput bold)\]\[$(tput setaf 3)\]V \[$(tput setaf 2)\]\W \[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
