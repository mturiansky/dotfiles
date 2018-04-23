# PATH updates
export PATH="$PATH:/usr/local/pulse"
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# ----------------------------
# OH-MY-ZSH SETUP
# ----------------------------

# oh-my-zsh directory
export ZSH=/home/mark/.oh-my-zsh

# theme found in $ZSH/themes
ZSH_THEME="af-magic2"

# dots while waiting for completion
# Commented out since it eats lines until ZSH 5.3.2 fixes
# COMPLETION_WAITING_DOTS="true"

# oh-my-zsh plugins
plugins=(colored-man-pages zsh-autosuggestions)


# change cache dir for oh-my-zsh
ZSH_CACHE_DIR=$HOME/.cache/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir $ZSH_CACHE_DIR
fi

# start up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ----------------------------
# ZSH OPTIONS
# ----------------------------

# allows comments in command line
setopt INTERACTIVE_COMMENTS

# correction for commands
setopt CORRECT

# correction for commands and arguments
# setopt CORRECT_ALL

# gets rid of 'zsh: you have running jobs.'
setopt NO_HUP

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----------------------------
# MISCELLANEOUS OPTIONS
# ----------------------------

# Borg options
export BORG_CACHE_DIR=/mnt/borgcache

# GTK2 configuration
export GTK2_RC_FILES=$HOME/.config/gtkrc-2.0

# for java dependencies
source /etc/profile.d/jre.sh
export _JAVA_AWT_WM_NONREPARENTING=1

# virtualenv-wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/code
source /usr/bin/virtualenvwrapper.sh

# editor
export EDITOR=vim
export SUDO_EDITOR=vim

# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null
then
    ssh-agent > ~/.cache/ssh-agent-env
fi

if [[ "$SSH_AGENT_PID" == "" ]]
then
    eval "$(cat ~/.cache/ssh-agent-env)" > /dev/null
fi

# misc
export TERM='xterm-256color'

# ----------------------------
# HOMEMADE FUNCTIONS
# ----------------------------

# touch and git add
tga () {
	touch $1
	git add $1
}

# for when the cat wants to nap on the laptop
catmode () {
	local trackpoint=$(xinput | grep 'TPPS/2 IBM TrackPoint' | awk '{print $6}' | awk -F= '{print $2}')
	local touchpad=$(xinput | grep 'SynPS/2 Synaptics TouchPad' | awk '{print $6}' | awk -F= '{print $2}')
	local keyboard=$(xinput | grep 'AT Translated Set 2 keyboard' | awk '{print $7}' | awk -F= '{print $2}')
	case $1 in
		off)
			local master=$(xinput | grep 'Virtual core keyboard' | awk '{print $5}' | awk -F= '{print $2}')
			xinput enable $trackpoint
			xinput enable $touchpad
			xinput reattach $keyboard $master
			;;
		*)
			xinput disable $trackpoint
			xinput disable $touchpad
			xinput float $keyboard
			;;
	esac
}

## stolen from http://dotshare.it/dots/461/
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not an extractable file."
  fi
}

_pmg () {
    workon pmg
    pmg $@
    deactivate
}

_phonopy () {
    workon phonopy
    phonopy $@
    deactivate
}

backup () {
    borg create -v -s -p -C zlib,6 --exclude /home/mark/.cache /mnt/backup-arch::archlinux-mark-$(date -Iminutes) ~
}

lmnt () {
    pushd /home/mark >> /dev/null
    case $1 in
        cori)
            sshfs mtur@cori.nersc.gov:/global/homes/m/mtur/ lmnt/cori
            ;;
        guild)
            sshfs mtur@guild.cnsi.ucsb.edu:/home/mtur lmnt/guild
            ;;
        knot)
            sshfs mtur@knot.cnsi.ucsb.edu:/home/mtur/ lmnt/knot
            ;;
        comet)
            sshfs mtur@comet.sdsc.xsede.org:/oasis/scratch/comet/mtur/temp_project/ lmnt/comet
            ;;
        braid)
            sshfs mtur@braid.cnsi.ucsb.edu:/home/mtur/ lmnt/braid
            ;;
        all)
            sshfs mtur@cori.nersc.gov:/global/homes/m/mtur/ lmnt/cori
            sshfs mtur@guild.cnsi.ucsb.edu:/home/mtur lmnt/guild
            sshfs mtur@knot.cnsi.ucsb.edu:/home/mtur/ lmnt/knot
            sshfs mtur@comet.sdsc.xsede.org:/oasis/scratch/comet/mtur/temp_project/ lmnt/comet
            sshfs mtur@braid.cnsi.ucsb.edu:/home/mtur/ lmnt/braid
            ;;
        unmount)
            fusermount -u lmnt/cori
            fusermount -u lmnt/guild
            fusermount -u lmnt/knot
            fusermount -u lmnt/comet
            fusermount -u lmnt/braid
            ;;
    esac
    popd >> /dev/null
}

# HOMEMADE ALIASES
alias pmg=_pmg
alias phonopy=_phonopy
alias xo=xdg-open
alias homevpn="sudo openvpn /etc/openvpn/client.conf"
alias homevpnd="sudo openvpn --daemon --askpass --config /etc/openvpn/client.conf"
alias ucsbvpn="sudo pulsesvc -C -h ps.vpn.ucsb.edu -u mturiansky -r \"UCSB-Remote-Access\" -U \"https://ps.vpn.ucsb.edu/ra\""
alias octave="octave-cli --no-gui -q"
