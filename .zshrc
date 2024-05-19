# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cidne/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
export PATH="/home/cidne/.local/gh_2.49.2_linux_386/bin:/home/cidne/.roswell/impls/x86-64/linux/sbcl/2.4.4/bin:$PATH"
