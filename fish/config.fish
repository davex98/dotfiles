if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_key_bindings fish_user_key_bindings

function fish_prompt
    set kubenv (kubectl config current-context)
    echo (basename $PWD) [$kubenv](fish_git_prompt)' ><> '
    printf '> '
end

abbr -a -- k 'kubectl'

function g --wraps git
  git $argv
end

function ch
  history |  awk "!a[\$0]++" |  fzf --tac --multi --header 'Copy history' | pbcopy
end

set __fish_git_prompt_showcolorhints
set fish_greeting

set -gx FZF_DEFAULT_OPTS '--height 20% --layout=reverse --border'
alias lc 'history -1 | pbcopy'
alias dot 'cd ~/.dotfiles'

abbr -a -- ga 'git add'
abbr -a -- gs 'git status'
abbr -a -- gf 'git fetch'
abbr -a -- gd 'git diff'
abbr -a -- gcm 'git commit -m' 
abbr -a -- gcb 'git checkout -b' 
abbr -a -- gco 'git checkout $(git branch --format=\'%(refname:short)\' | fzf)'
abbr -a -- m make

abbr -a -- fj 'cd $(git rev-parse --show-toplevel)'

abbr -a -- gh fzf-cd-widget

abbr -a -- l 'eza'
abbr -a -- ll 'eza -l'
abbr -a -- lll 'eza -la'

abbr -a -- t 'terraform'
abbr -a -- last-time 'math $CMD_DURATION/1000'

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH $HOME/kubectl-plugins
set -x PATH $PATH $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin

set -gx KUBE_EDITOR nvim
