# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set -o noclobber

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTCONTROL=ignoredups:erasedups  # no duplicate entries
HISTSIZE=100000                   # big big history
HISTFILESIZE=100000               # big big history

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Recursive cd, ie cd **/test ./one/two/test
shopt -s autocd;

# Recursive globbing **/*.txt
shopt -s globstar;

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
    xterm-color|*-256color) color_prompt=yes;;
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
fi

alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ll -A'
alias l='ls -CF'

alias python=python3
alias pip=pip3

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

if [ -f ~/.bash_machine ]; then
    . ~/.bash_machine
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
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

# gulp completion

eval "$(gulp --completion=bash)"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

###-begin-ng-completion###
#

# ng command completion script
#   This command supports 3 cases.
#   1. (Default case) It prints a common completion initialisation for both Bash and Zsh.
#      It is the result of either calling "ng completion" or "ng completion -a".
#   2. Produce Bash-only completion: "ng completion -b" or "ng completion --bash".
#   3. Produce Zsh-only completion: "ng completion -z" or "ng completion --zsh".
#
# Usage: . <(ng completion --bash) # place it appropriately in .bashrc or
#        . <(ng completion --zsh) # find a spot for it in .zshrc
#
_ng_completion() {
  local cword pword opts

  COMPREPLY=()
  cword=${COMP_WORDS[COMP_CWORD]}
  pword=${COMP_WORDS[COMP_CWORD - 1]}

  case ${pword} in
    ng|help) opts="--version -v b build completion doc e e2e eject g generate get help l lint n new s serve server set t test v version xi18n" ;;
    b|build) opts="--aot --app --base-href --delete-output-path --deploy-url --environment --extract-css --extract-licenses --i18n-file --i18n-format --locale --output-hashing --output-path --poll --preserve-symlinks --progress --sourcemaps --stats-json --target --vendor-chunk --verbose --watch -a -aot -bh -d -dop -e -ec -extractLicenses -i18nFile -i18nFormat -locale -oh -op -poll -pr -preserveSymlinks -sm -statsJson -t -v -vc -w" ;;
    completion) opts="--all --bash --zsh -a -b -z" ;;
    doc) opts="--search -s" ;;
    e|e2e) opts="--aot --app --base-href --config --delete-output-path --deploy-url --disable-host-check --element-explorer --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve --sourcemaps --specs --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch --webdriver-update -H -a -aot -bh -c -d -disableHostCheck -dop -e -ec -ee -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -o -oh -op -p -pc -poll -pr -preserveSymlinks -s -sm -sp -ssl -sslCert -sslKey -t -v -vc -w -wu" ;;
    eject) opts="--aot --app --base-href --delete-output-path --deploy-url --environment --extract-css --extract-licenses --force --i18n-file --i18n-format --locale --output-hashing --output-path --poll --preserve-symlinks --progress --sourcemaps --target --vendor-chunk --verbose --watch -a -aot -bh -d -dop -e -ec -extractLicenses -force -i18nFile -i18nFormat -locale -oh -op -poll -pr -preserveSymlinks -sm -t -v -vc -w" ;;
    g|generate) opts="--dry-run --lint-fix --verbose -d -lf -v" ;;
    get) opts="--global -global" ;;
    l|lint) opts="--fix --force --format --type-check -fix -force -format -typeCheck" ;;
    n|new) opts="--directory --dry-run --inline-style --inline-template --link-cli --minimal --prefix --routing --skip-commit --skip-git --skip-install --skip-tests --source-dir --style --verbose -d -dir -is -it -lc -minimal -p -routing -sc -sd -sg -si -st -style -v" ;;
    s|serve|server) opts="--aot --app --base-href --delete-output-path --deploy-url --disable-host-check --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --sourcemaps --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch -H -a -aot -bh -d -disableHostCheck -dop -e -ec -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -o -oh -op -p -pc -poll -pr -preserveSymlinks -sm -ssl -sslCert -sslKey -t -v -vc -w" ;;
    set) opts="--global -g" ;;
    t|test) opts="--app --browsers --code-coverage --colors --config --log-level --poll --port --progress --reporters --single-run --sourcemaps --watch -a -browsers -c -cc -colors -logLevel -poll -port -progress -reporters -sm -sr -w" ;;
    --version|-v|v|version) opts="--verbose -verbose" ;;
    xi18n) opts="--app --i18n-format --locale --out-file --output-path --progress --verbose -a -f -l -of -op -progress -verbose" ;;
    *) opts="" ;;
  esac

  COMPREPLY=( $(compgen -W '${opts}' -- $cword) )

  return 0
}

complete -o default -F _ng_completion ng
###-end-ng-completion###
