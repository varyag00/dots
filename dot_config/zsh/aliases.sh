#!/bin/bash
alias manage="python manage.py"
# alias pip="python -m pip"
alias reload="source ~/.zshrc"

if type "nvim" &>/dev/null; then
	alias vim=nvim
	alias vi=nvim
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
