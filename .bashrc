# ~/.bashrc: executed by bash(1) for non-login shells.

export MANPATH="/usr/local/man:$MANPATH"

umask 022

export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS=gxfxcxdxbxegedabagacad

LOCALRC=.bashrc-local
if [ -f $LOCALRC ];
then
   source $LOCALRC
fi

export GSK=/Users/juanre/.gsk
export GSKRES=~/.gskres/

export ANDADO_GOOGLE_API=AIzaSyAH7kzE4ZCTci0n9FHMYjEy8eUDUxUlk1c

alias slicer='/Applications/Slic3r.app/Contents/MacOS/slic3r --layer-height=0.1 --export-svg'

#  Aliases
alias aassh='ssh -i /Users/juanre/.ssh/aws-gsk.pem ubuntu@ec2-107-20-206-125.compute-1.amazonaws.com'
# alias tssh='ssh -i /Users/juanre/.ssh/aws-gsk.pem ubuntu@ec2-54-225-170-202.compute-1.amazonaws.com'

alias fassh='ssh -p 22 -i /Users/juanre/.ssh/aws-gsk.pem ubuntu@52.86.240.65'
alias nssh='ssh -p 22 -i /Users/juanre/.ssh/aws-gmaps.pem ubuntu@35.167.112.99'

alias wssh='ssh -A ubuntu@ec2-52-2-120-14.compute-1.amazonaws.com'

alias tssh='ssh -A ubuntu@ec2-34-203-5-7.compute-1.amazonaws.com'

alias gmv='git mv'
alias grm='git rm'
alias gci='git commit -a'
alias e="emacsclient -t --socket-name=/tmp/emacs1000/server"

alias gcl="git commit -am 'Closing'; git push"

alias ga='git add'
alias gpu='git push'
alias gl='git log'
alias gst='git status'
alias gd='git diff'
alias gm='git add -A && git commit -m'
alias gma='git commit -am'

alias co='git checkout'
alias push='git push'
alias pull='git pull'

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'

alias apt-search='apt-cache search'

alias python='/usr/local/bin/python3'
alias pip="pip3"

#      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1›/'
}

# export PS1="\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
export PS1="\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\w$ "

#export LANG=C

export LISPLIB=$HOME/lib/lisp

export PYTHONSTARTUP=~/.pythonrc
export PYTHONPATH=.:..  # This allows you to run files from the root directory of a module
export PATH=~/bin:/usr/local/bin:/usr/local/git/bin:$PATH:/usr/local/texlive/2015/bin/x86_64-darwin
export PATH=/opt/bin:/opt/local/bin:/opt/local/sbin:$PATH

# Calibre
export PATH=$PATH:/Applications/calibre.app/Contents/MacOS/


# ImageMagick
#export MAGICK_HOME=/usr/local/ImageMagick-6.9.1
#export PATH=$MAGICK_HOME/bin:$PATH
#export LD_LIBRARY_PATH=$MAGICK_HOME/lib:$LD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH=$MAGICK_HOME/lib:$DYLD_LIBRARY_PATH:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
#export PERL5LIB=~/lib/perl:$PERL5LIB

export LC_CTYPE=en_US.UTF-8
