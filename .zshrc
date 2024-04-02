autoload -Uz colors && colors

# # peco: 過去に実行したコマンドを選択
# function peco-select-history() {
#     =$(\history -n -r 1 | peco --query "$LBUFFER")
#   CURSOR=$#BUFFER
#   zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history

# fzf: 過去に実行したコマンドを選択
incremental_search_history() {
  selected=`history -E 1 | fzf | cut -b 26-`
  BUFFER=`[ ${#selected} -gt 0 ] && echo $selected || echo $BUFFER`
  CURSOR=${#BUFFER}
  zle redisplay
}
zle -N incremental_search_history
bindkey "^r" incremental_search_history

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# zsh
## no match found 対策
setopt +o nomatch

## 重複を記録しない
setopt hist_ignore_dups

## 履歴の共有
setopt share_history

# コマンド履歴
## 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

## メモリに保存される履歴の件数
export HISTSIZE=1000

## 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# エイリアス
alias ..='cd ..'
alias mkdir='mkdir -p'
alias relogin='exec $SHELL -l'
alias md='vim ./*.md'
alias f='open .'
alias vim='nvim'
alias vi='nvim'


## ツール置き換え
alias cat='bat -p'
alias ls='eza --time-style=long-iso -g'
alias ll='eza --time-style=long-iso -hgl --git'
alias la='eza --time-style=long-iso -ahgl --git'
alias l1='eza -1'
alias tree='eza -T --git-ignore'
alias diff='delta'

## マージ済みローカルブランチの削除
alias git-delete-merged-local-branch="git branch --merged|xargs git branch -d"

# 関数
## Finderで開いているディレクトリへ移動
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# 初期設定
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi

PROMPT="%F{green}%n%f %F{cyan}($(arch))%f:%F{blue}%~%f"$'\n'"%# "
