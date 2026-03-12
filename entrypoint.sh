#!/bin/bash

# Write Claude credentials from macOS Keychain passthrough (if provided)
if [ -n "${CLAUDE_CREDENTIALS:-}" ]; then
    mkdir -p "$HOME/.claude"
    echo "$CLAUDE_CREDENTIALS" > "$HOME/.claude/.credentials.json"
    unset CLAUDE_CREDENTIALS
fi

# Launch claude, then drop to an interactive bash shell when it exits
claude --dangerously-skip-permissions "$@"
exec bash
