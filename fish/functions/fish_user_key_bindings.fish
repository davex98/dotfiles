function fish_user_key_bindings
  fish_vi_key_bindings

  bind -M insert -m default jk backward-char force-repaint

  bind -M default H beginning-of-line
  bind -M default L end-of-line

  bind -M insert \co 'clear; commandline -f repaint'
  bind -M default \co 'clear; commandline -f repaint'
end

fzf_key_bindings
