source -F "#{d:current_file}/status-format.tmux"

set-option -g status-style bg=default
set status-bg default

# 0f\��5lve"+pjvi'"+pk_wYjjo:0Dkvi'pjddkkk:w:!tmux source %

# .!%:p:h/dim '\#383c45' 0.4
set @window-color '#383c45'
set @window-dim '#212429'

# .!%:p:h/dim '\#603dbf' 0.4
set @active-window-color '#603dbf'
set @active-window-dim '#31245a'

# set @window-pre-format ' #[fg=#{@window-dim}]�'
set -u @window-post-format '#[fg=#{@window-dim}]'

# set -g window-status-format '#[bg=#{@window-dim}]#I '
# set -g window-status-current-format \
# '#[bg=#{@window-dim} fg=#{@window-color}]#[bg=#{@window-color} fg=#abcdef]#I#[fg=#{@window-color} bg=#{@window-dim}] '

set -g window-status-format \
'#[fg=#{@window-color}]\
#[bg=#{@window-color} fg=#abcdef]#I\
#[fg=#{@window-color} bg=#{@window-dim}]\
#[fg=#abcdef] #W\
#[fg=#{@window-dim} bg=default] '

set -g window-status-current-format \
'#[fg=#{@active-window-color}]\
#[bg=#{@active-window-color} fg=#abcdef]#I\
#[fg=#{@active-window-color} bg=#{@active-window-dim}]\
#[fg=#abcdef] #W\
#[fg=#{@active-window-dim} bg=default] '




set status-left ''
set -g status-left-length 100

# vim:ft=tmux
