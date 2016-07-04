# GTK2 configuration
export GTK2_RC_FILES=$HOME/.config/gtkrc-2.0

# needed for ruby executables to run
export PATH="/home/mark/.gem/ruby/2.2.0/bin:$PATH"

export ZSH=$HOME/.oh-my-zsh

# for java dependencies
source /etc/profile.d/jre.sh

# zsh theme specifics
ZSH_THEME="af-magic2"

export TERM="xterm-256color"

setopt RM_STAR_WAIT

setopt interactivecomments

setopt CORRECT

setopt NO_HUP

source $ZSH/oh-my-zsh.sh

# virtualenv-wrapper
export WORKON_HOME=$HOME/.virtualenvs

export PROJECT_HOME=$HOME/NewCode

source /usr/bin/virtualenvwrapper.sh

# homemade stuffs
alias xo=xdg-open

tga () {
	touch $1
	git add $1
}

alias homevpn="sudo openvpn /etc/openvpn/client.conf"
alias homevpnd="sudo openvpn --daemon --askpass --config /etc/openvpn/client.conf"
