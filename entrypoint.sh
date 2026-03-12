#!/bin/bash
# Launch claude, then drop to an interactive bash shell when it exits
claude --dangerously-skip-permissions "$@"
exec bash
