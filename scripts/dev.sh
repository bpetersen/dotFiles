tmux has-session -t dev
if [ $? != 0 ]
then
  cd ~/Repos/$1
  tmux new-session -s dev -n editor -d
  tmux split-window -h -p 40 -t dev
  tmux split-window -v -p 40 -t dev
  tmux new-window -n console -t dev
  tmux send-keys -t dev:2 'cd ~' C-m
  tmux send-keys -t dev
  tmux select-window -t dev:1
fi
tmux attach -t dev
