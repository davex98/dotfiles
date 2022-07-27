if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_key_bindings fish_user_key_bindings

function fish_prompt
    #echo (basename $PWD) (fish_git_prompt) "><> "
    printf '%s' (basename $PWD) (fish_git_prompt) ' ><> '
end

set __fish_git_prompt_showcolorhints
set fish_greeting

fzf_key_bindings
set -gx FZF_DEFAULT_OPTS '--height 15% --layout=reverse --border'
alias lc 'history -1 | xclip -sel clip'
alias dot 'cd ~/.dotfiles'

function gcm
    ls -l $argv
end

abbr -a -U -- ga 'git add'
abbr -a -U -- gs 'git status'
abbr -a -U -- gf 'git fetch'
abbr -a -U -- gd 'git diff'
abbr -a -U -- gcm 'git commit -m'
abbr -a -U -- gco 'git checkout $(git branch --format=\'%(refname:short)\' | fzf)'
abbr -a -U -- v nvim
abbr -a -U -- m make

abbr -a -U -- p 'sudo pacman'
abbr -a -U -- up 'sudo pacman -Syu'

abbr -a -U -- l 'exa'
abbr -a -U -- ll 'exa -l'
abbr -a -U -- lll 'exa -la'
