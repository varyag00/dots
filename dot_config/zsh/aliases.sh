#!/bin/bash

alias reload="source $ZDOTDIR/.zshrc"

# don't alias manage when it's being managed by e.g. poetry
# if ! type "manage" &>/dev/null; then # BUG: this always runs. Probably an unexpected return code due to !
# 	alias manage="python manage.py"
# fi
# alias pip="python -m pip"
alias pyman="python manage.py"
if type "pipx" &>/dev/null; then
	eval "$(register-python-argcomplete pipx)"
fi

if type "nvim" &>/dev/null; then
	alias vim=nvim
	alias vi=nvim
fi

if type "direnv" &>/dev/null; then
	eval "$(direnv hook zsh)"
fi

if type "atuin" &>/dev/null; then
	eval "$(atuin init zsh)"
fi

if type "zoxide" &>/dev/null; then
	eval "$(zoxide init zsh)"
	alias cd=z
	alias cdi=zi
fi

if type "lsd" &>/dev/null; then
	alias ls="lsd"
	alias la="lsd --long --all"
fi

if type "vtop" &>/dev/null; then
	alias top="vtop"
fi

if type "terraform" &>/dev/null; then
	alias tf="terraform"
fi

if type "duf" &>/dev/null; then
	alias df="duf"
fi

if type "bat" &>/dev/null; then
	alias cat="bat"
# apt repo has a name conflict so it uses this name
elif type "batcat" &>/dev/null; then
	alias cat="batcat"
fi

if type "tre" &>/dev/null; then
	alias tree="tre"
fi

if type "gping" &>/dev/null; then
	alias ping="gping"
fi

if type "dog" &>/dev/null; then
	alias dig="dog"
fi

if type "xsel" &>/dev/null; then
	alias pbcopy="xsel --clipboard --input"
	alias pbpaste="xsel --clipboard --output"
fi

if type "chezmoi" &>/dev/null; then
	alias cm="chezmoi"
fi

if type "lazygit" &>/dev/null; then
	alias lgit="lazygit"
fi

if type "lazydocker" &>/dev/null; then
	alias ldock="lazydocker"
fi

if type "fuck" &>/dev/null; then
	eval "$(thefuck --alias)"
fi

# # NOTE: testing out nala, a better alternative to apt
# # see: https://christitus.com/stop-using-apt/
# # make sure to run sudo nala fetch on new systems
# if type "nala" &>/dev/null; then
# 	apt() {
# 		command nala "$@"
# 	}
# 	sudo() {
# 		if [ "$1" = "apt" ]; then
# 			shift
# 			command sudo nala "$@"
# 		else
# 			command sudo "$@"
# 		fi
# 	}
# fi
