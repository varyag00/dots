# From https://github.com/beauwilliams/awesome-fzf

function fzf-rm() {
	if [[ "$#" -eq 0 ]]; then
		local files
		files=$(find . -maxdepth 1 -type f | fzf --multi)
		echo $files | xargs -I '{}' rm {} #we use xargs to capture filenames with spaces in them properly
	else
		command rm "$@"
	fi
}

# Man without options will use fzf to select a page
function fzf-man() {
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
		return $?
	fi
}

# Search aliases and functions
function fzf-aliases-functions() {
	CMD=$(
		(
			(alias)
			(functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
		) | fzf | cut -d '=' -f1
	)
	eval $CMD
}
alias fzf-af=fzf-aliases-functions

function fzf-env-vars() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}
alias fzf-env=fzf-env-vars

function fzf-kill-processes() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}
alias fzf-kp=fzf-kill-processes

function fzf-git-status() {
    git rev-parse --git-dir > /dev/null 2>&1 || { echo "You are not in a git repository" && return }
    local selected
    selected=$(git -c color.status=always status --short |
        fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //')
            if [[ $selected ]]; then
                for prog in $(echo $selected);
                do; $EDITOR $prog; done;
            fi
    }
alias fzf-gs=fzf-git-status

#List Awesome FZF Functions
function fzf-awesome-list() {
if [[ -f $ZSHDIR/fzf-custom.zsh ]]; then
    selected=$(grep -E "(function fzf-)(.*?)[^(]*" $ZSHDIR/fzf-custom.zsh | sed -e "s/function fzf-//" | sed -e "s/() {//" | grep -v "selected=" | fzf --reverse --prompt="awesome fzf functions > ")
else
    echo "fzf-custom.zsh not found"
fi
    case "$selected" in
        "");; #don't throw an exit error when we dont select anything
        *) "fzf-"$selected;;
    esac
}
alias fzf-custom=fzf-awesome-list
