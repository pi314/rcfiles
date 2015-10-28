# force source .zshenv to prevent system modify it
source $HOME/.rcfiles/zsh/.zshenv

##########################
# Prompt
##########################
if [[ -f $HOME/.rcfiles/zsh/.zshrc.prompt ]]; then
    source $HOME/.rcfiles/zsh/.zshrc.prompt
fi

##########################
# Aliases
##########################
if [[ -f $HOME/.rcfiles/zsh/.zshrc.aliases ]]; then
    source $HOME/.rcfiles/zsh/.zshrc.aliases
fi

##########################
# Functions
##########################
if [[ -d $HOME/.rcfiles/zsh/functions ]]; then
    for i in $(ls $HOME/.rcfiles/zsh/functions/); do
        source $HOME/.rcfiles/zsh/functions/$i
    done
fi

##########################
# Local Files
##########################
if [[ -f $HOME/.zshlocal ]]; then
    source $HOME/.zshlocal
fi

##########################
# History
##########################
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

##########################
# Bindkeys
##########################
bindkey -v
zle -A kill-whole-line      vi-kill-line
zle -A backward-kill-word   vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char

bindkey "\e[H"      beginning-of-line
bindkey "\e[1~"     beginning-of-line   # for screen
bindkey "\eOH"      beginning-of-line   # for cygwin + mosh

bindkey "\e[F"      end-of-line
bindkey "\e[4~"     end-of-line         # for screen
bindkey "\eOF"      end-of-line         # for cygwin + mosh

bindkey "\ej"       backward-word
bindkey "\ek"       forward-word

bindkey "\e[A"      up-line-or-search
bindkey "\e[B"      down-line-or-search
bindkey '^R'        history-incremental-search-backward

bindkey "\e[3~"     delete-char


##########################
# Completions
##########################
fpath=($HOME/.rcfiles/zsh/completions $fpath)

autoload -Uz compinit
compinit -u

autoload -U colors
colors

zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true

