if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.config/dotfiles/.p10k.zsh ]] || source ~/.config/dotfiles/.p10k.zsh

export PNPM_HOME="/Users/$USER/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="${HOME}/.pyenv/shims:${PATH}"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

alias cls="clear"
alias gg="lazygit"
export KUBE_NAME=""
alias klogs="kubectl -n $KUBE_NAME get po --no-headers | fzf --preview 'kubectl -n $KUBE_NAME logs {1} --tail=5 | jq .' | awk '{print \$1}' | xargs -n 2 sh -c 'kubectl -n $KUBE_NAME logs \$0 -f --tail=100' | jq ."
alias db="~/.config/scripts/dbclient.sh"
