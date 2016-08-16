# OH-MY-ZSH SETUP

# oh-my-zsh directory
export ZSH=/usr/share/oh-my-zsh

# theme found in $ZSH/themes
ZSH_THEME="af-magic2"

# dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# oh-my-zsh plugins
plugins=()

# add ruby to path
export PATH="/home/mark/.gem/ruby/2.2.0/bin:$PATH"

# change cache dir for oh-my-zsh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir $ZSH_CACHE_DIR
fi

# start up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ZSH OPTIONS

# allows comments in command line
setopt INTERACTIVE_COMMENTS

# correction for commands
setopt CORRECT

# correction for commands and arguments
# setopt CORRECT_ALL

# gets rid of 'zsh: you have running jobs.'
setopt NO_HUP

# MISCELLANEOUS OPTIONS

# GTK2 configuration
export GTK2_RC_FILES=$HOME/.config/gtkrc-2.0

# for java dependencies
source /etc/profile.d/jre.sh

# virtualenv-wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/NewCode
source /usr/bin/virtualenvwrapper.sh

# homemade functions
tga () {
	touch $1
	git add $1
}

# homemade aliases
alias xo=xdg-open
alias homevpn="sudo openvpn /etc/openvpn/client.conf"
alias homevpnd="sudo openvpn --daemon --askpass --config /etc/openvpn/client.conf"
