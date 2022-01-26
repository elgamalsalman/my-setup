if status is-interactive
	alias ls='exa -lags=type --color-scale --header --icons --git';
	alias lss='exa -ags=type --color-scale --header --icons --git';
	alias neofetch='echo;/usr/bin/neofetch';

	neofetch;

	set fish_greeting ""
	set fish_color_cwd 1793d0
	set fish_color_user 2773a0

	set EXA_COLORS 'hd=30:uu=32:gu=32:sn=35:sb=35:da=03;34:uu=30:gu=30:ur=36:uw=36:ux=36:ue=36:gr=36:gw=36:gx=36:tr=36:tw=36:tx=36:';
	export EXA_COLORS;
end
