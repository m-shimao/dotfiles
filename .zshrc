alias vim='nvim'
alias vi='nvim'

# 過去に実行したコマンドを選択。
function peco-select-history() {
    =$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
