#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias ls='exa -lags=type --color-scale --header --icons --git'

neofetch;

EXA_COLORS='hd=30:uu=02;03;32:gu=02;03;32:';
export EXA_COLORS
