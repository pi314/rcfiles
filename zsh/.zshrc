# force source .zshenv to prevent system modifying it
source $HOME/.zsh/.zshenv


###############################################################################
# Completions
###############################################################################
fpath=($fpath $HOME/.zsh/completions)

# ``antigen apply`` would do it
# autoload -Uz compinit
# compinit -u

zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs true

# cool formatting and messages
# http://unix.stackexchange.com/a/214699
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''


###############################################################################
# Prompt
###############################################################################
if [[ -f $HOME/.zsh/zsh.prompt ]]; then
    source $HOME/.zsh/zsh.prompt
fi


###############################################################################
# Aliases
###############################################################################
if [[ -f $HOME/.zsh/zsh.aliases ]]; then
    source $HOME/.zsh/zsh.aliases
fi


###############################################################################
# Functions
###############################################################################
if [[ -d $HOME/.zsh/functions ]]; then
    for i in $(ls $HOME/.zsh/functions/); do
        source $HOME/.zsh/functions/$i
    done
fi


###############################################################################
# Local Files & antigen plugins
###############################################################################
if [[ -f $HOME/.zshlocal ]]; then
    source $HOME/.zsh/antigen.zsh
    source $HOME/.zshlocal
    antigen apply
fi


###############################################################################
# History
###############################################################################
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000


###############################################################################
# Bindkeys
###############################################################################
bindkey -v
zle -A kill-whole-line      vi-kill-line
# zle -A backward-kill-word   vi-backward-kill-word
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
