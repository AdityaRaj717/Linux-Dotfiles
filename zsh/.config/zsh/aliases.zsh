# ========================================
# Package Management
# ========================================
alias i='sudo pacman -S'
alias upgrade='sudo pacman -Syu'
alias search='pacman -Qs'
alias remove='sudo pacman -Rns'
alias cleanch='sudo pacman -Scc'
alias fixpacman='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -Rsn $(pacman -Qtdq)'

# ========================================
# System
# ========================================
alias c='clear'
alias shutdown='systemctl poweroff'
alias jctl='journalctl -p 3 -xb'
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ========================================
# File Management
# ========================================
# Eza (better ls)
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias cd='z'

# ========================================
# Applications
# ========================================
alias ff='fastfetch'
alias r='ranger'
alias ani='ani-cli'
alias fs='nvim $(fzf -m --preview="bat --color=always {}")'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias cat='bat'

# Ranger with directory tracking
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# ========================================
# Additional Aliases (if you have more)
# ========================================
# Add any custom aliases below this line
