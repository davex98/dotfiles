function ch
if not set -q argv[1]
    echo 'provide service name'
    exit
else
    echo 'yes'
end

end
alias hy="
  fc -ln 0 |
  awk '!a[\$0]++' |
  fzf --tac --multi --header 'Copy history' |
  xsel --clipboard
"
