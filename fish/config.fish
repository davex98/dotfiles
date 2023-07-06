if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_key_bindings fish_user_key_bindings

function fish_prompt
    printf '%s' (basename $PWD) (fish_git_prompt) ' ><> '
    echo
    printf '> '
end

function g --wraps git
  git $argv
end

function k --wraps kubectl
  kubectl $argv
end

set __fish_git_prompt_showcolorhints
set fish_greeting

set -gx FZF_DEFAULT_OPTS '--height 20% --layout=reverse --border'
alias lc 'history -1 | pbcopy'
alias dot 'cd ~/.dotfiles'

abbr -a -U -- ga 'git add'
abbr -a -U -- gs 'git status'
abbr -a -U -- gf 'git fetch'
abbr -a -U -- gd 'git diff'
abbr -a -U -- gcm 'git commit -m' 
abbr -a -U -- gcb 'git checkout -b' 
abbr -a -U -- gco 'git checkout $(git branch --format=\'%(refname:short)\' | fzf)'
abbr -a -U -- m make

abbr -a -U -- fj 'cd $(git rev-parse --show-toplevel)'

abbr -a -U -- l 'exa'
abbr -a -U -- ls 'exa'
abbr -a -U -- ll 'exa -l'
abbr -a -U -- lll 'exa -la'

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
fish_add_path /Users/kuba/.rbenv/versions/3.1.2
source (rbenv init - | psub)
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# pnpm
set -gx PNPM_HOME "/Users/kuba/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
