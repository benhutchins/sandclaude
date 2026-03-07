# sandclaude

My personal, opinionated way to run [Claude Code](https://docs.anthropic.com/en/docs/claude-code) without restrictions in a sandboxed Docker container. The image is tailored to the tools I use on a daily basis — it's not meant to be a generic solution for others, but feel free to fork and adapt it to your own needs.

## Prerequisites

- Docker
- Claude Code installed locally (for initial OAuth login)
- `gh` CLI authenticated (optional, for GitHub access inside the container)

## Installation

Clone the repo and make the script executable:

```bash
chmod +x sandclaude
```

Optionally, add it to your PATH:

```bash
sudo ln -s "$(pwd)/sandclaude" /usr/local/bin/sandclaude
```

## Usage

```
sandclaude [-s] [-b] [-r] [-h] [workspace]
```

### Options

| Flag | Description |
|------|-------------|
| `-s` | Open a bash shell instead of Claude |
| `-b` | Force rebuild of the Docker image |
| `-r` | Resume the previous Claude session |
| `-h` | Show help |

### Arguments

| Argument | Description |
|----------|-------------|
| `workspace` | Path to mount as `/workspace` (default: current directory) |

### Examples

```bash
# Run Claude Code in the current directory
sandclaude

# Run Claude Code in a specific project
sandclaude ~/projects/myapp

# Open a shell in the container for debugging
sandclaude -s

# Force rebuild the image and resume the last session
sandclaude -b -r
```

## What's in the container

The Docker image is based on Ubuntu 24.04 and includes:

- Node.js 22
- Go 1.26.1
- Python 3
- GCC cross-compilers (aarch64, arm, mingw-w64)
- GoReleaser
- GitHub CLI (`gh`)
- Jira CLI

## How it works

1. The script checks for Claude credentials at `~/.claude/.credentials.json` (run `claude` locally first to authenticate via OAuth).
2. It builds the Docker image automatically on first run or when the Dockerfile changes.
3. Your workspace, Claude config, GitHub config, and Jira config are mounted into the container.
4. Claude Code runs as a non-root user with UID/GID matching your host user.

## License

[Apache License 2.0](LICENSE)
