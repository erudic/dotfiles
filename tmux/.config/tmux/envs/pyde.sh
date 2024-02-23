#!/bin/sh
tmux new-session \; \
	send-keys 'source .venv/bin/activate' C-m \; \
	send-keys 'nvim' C-m \; \
	split-window -v -p 30 \; \
	send-keys 'source .venv/bin/activate' C-m \;
