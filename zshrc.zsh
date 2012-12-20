# zshrc.zsh #
# may be sourced in .zshrc (if used with oh-my-zsh)

# aliases
alias vi='vim'
alias ta='tig --all'

# zsh options
HISTSIZE=1000
SAVEHIST=1000
#HISTFILE=~/.history

unsetopt correct_all

# path
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# term
#export TERM=screen-256color

# Locale
# default for all unset LC_* variables
# used by hunspell for spell check
export LANG=en_GB.UTF-8

# ls colors
#export CLICOLOR="YES"
#export LSCOLORS="gxfxcxdxbxegedabagacad"

# man
export PAGER="less"

# svn
export SVN_EDITOR=/usr/local/bin/vim

# editor
export EDITOR=/usr/local/bin/vim
# if using vi as an editor, zsh switch to "vi mode" automaticaly, which disable ctrl+a, ctrl+e...etc. use "emacs mode"
#bindkey -e

# python path (brew installed stuffs)
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages/

# JAVA
export JAVA_HOME=/Library/Java/Home
export JAVA_OPTS="-XX:MaxPermSize=1024m"

# SBT
export SBT_OPTS=-XX:MaxPermSize=256M

# MacPort
# installation path
#MACPORT=$HOME/macport
#MACPORT_PATH=$MACPORT/bin:$MACPORT/sbin
# use macport's python site-package
#export PYTHONPATH=$MACPORT/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages
# use macport's mans
#export MANPATH=$MACPORT/share/man:$MACPORT/man:$MANPATH
# home local bins + macport
#export PATH=$HOME/Source/bin:$HOME/local/bin:$PATH
# macport
#export PATH=$MACPORT_PATH:$PATH

# ccache
# export PATH=$MACPORT/libexec/ccache:$PATH

# postgresql
# export PATH=$MACPORT/lib/postgresql83/bin:$PATH



# ########################
# prompt
# ########################

## # have a look to: http://libraryofmike.org/linux/getting-a-pretty-colour-prompt-with-zsh/
## autoload colors
## colors
## #fpath=(~/myfns $fpath)
## autoload -U promptinit
## promptinit
## 
## if [[ $UID -eq 0 ]]; then
## 	userstring='%S%n%s'
## else
## 	userstring='%B%n%b'
## fi
## 
## # basic sentence for specifying colors 
## # %{${fg[red]}%}
## # check http://aperiodic.net/phil/prompt/
## 
## # [yellow] login [white] @ [green] hostname [white] PWD % or #
## export PROMPT="%{${fg[yellow]}%}${userstring}%{${fg[white]}%} @%{${fg[red]}%}%m%{${fg[magenta]}%} %5d %# %{${fg[default]}%}"
## # [red] number_of_jobs [magenta] date time
## export RPROMPT="[%{${fg[red]}%}%j%{${fg[default]}%}] %{${fg[default]}%}%D %T%{${fg[default]}%}"

