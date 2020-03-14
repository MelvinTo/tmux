#!/usr/bin/env bash

# a tmux color scheme inspired by dracula
# author: Dane Williams


main()
{

  # Dracula Color Pallette
  white='#f8f8f2'
  gray='#44475a'
  dark_gray='#282a36'
  light_purple='#bd93f9'
  dark_purple='#6272a4'
  cyan='#8be9fd'
  green='#50fa7b'
  orange='#ffb86c'
  pink='#ff79c6'

  # set refresh interval
  tmux set-option -g status-interval 1

  # set length 
  tmux set-option -g status-left-length 100
  tmux set-option -g status-right-length 100

  # pane border styling
  tmux set-option -g pane-active-border-style "fg=${dark_purple}"
  tmux set-option -g pane-border-style "fg=${gray}"

  # message styling
  tmux set-option -g message-style "bg=${gray},fg=${white}"
 
  # status bar
  tmux set-option -g status-style "bg=${gray},fg=${white}"
  tmux set-option -g status-left "#[bg=${green},fg=${dark_gray}]#{?client_prefix,#[bg=${orange}],} ☺ " 
  tmux set-option -g status-right "#[fg=${dark_gray},bg=${cyan}] tructus "
  tmux set-option -ga status-right "#[fg=${dark_gray},bg=${pink}] #(~/.tmux/plugins/tmux-dracula/battery.sh) #[fg=${white},bg=${dark_purple}] %a %H:%M #(date +%Z) %m/%d/%Y "
  
  # window tabs 
  tmux set-window-option -g window-status-current-format "#[fg=${white},bg=${dark_purple}] #I #W "
  tmux set-window-option -g window-status-format "#[fg=${white}]#[bg=${gray}] #I #W "

}

# run main function
main

