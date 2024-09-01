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

abbr -a  -- ga 'git add'
abbr -a  -- gs 'git status'
abbr -a  -- gf 'git fetch'
abbr -a  -- gd 'git diff'
abbr -a  -- gcm 'git commit -m' 
abbr -a  -- gcb 'git checkout -b' 
abbr -a  -- gco 'git checkout $(git branch --format=\'%(refname:short)\' | fzf)'
abbr -a  -- m make

abbr -a  -- fj 'cd $(git rev-parse --show-toplevel)'

abbr -a  -- l 'exa'
abbr -a  -- ls 'exa'
abbr -a  -- ll 'exa -l'
abbr -a  -- lll 'exa -la'

set -x GOPATH $HOME/go
set -x PATH $PATH $HOME/.pub-cache/bin
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH $HOME/fvm/default/bin

fish_add_path /Users/kuba/.rbenv/versions/3.1.2
source (rbenv init - | psub)
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# pnpm
set -gx PNPM_HOME "/Users/kuba/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
