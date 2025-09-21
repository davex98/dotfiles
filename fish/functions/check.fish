function check
if not set -q argv[1]
    echo 'provide service name'
    exit
else
    echo 'yes'
end
  /Users/kuba/.config/fish/functions/check.sh check-$argv[1] $argv[1]
end
