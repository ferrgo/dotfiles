#!/bin/bash

usage() {
  echo "Usage: $(basename "$0") -d <directory> [-s <session_name>] [-p code|write] [-a cursor|claude]"
  echo ""
  echo "Options:"
  echo "  -d, --directory <dir>        Project directory (required)"
  echo "  -s, --session <name>         Override session name (default: directory basename)"
  echo "  -p, --profile code|write     Session profile (default: code)"
  echo "      code:  opens nvim + shell windows"
  echo "      write: opens a single write window"
  echo "  -a, --agent cursor|claude    Start an agent window in the session"
  echo "  -h, --help                   Show this help message"
  exit 1
}

DIR=""
SESSION_NAME=""
AGENT=""
PROFILE="code"

# Parse options
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--directory)
      DIR="$2"
      shift 2
      ;;
    -s|--session)
      SESSION_NAME="$2"
      shift 2
      ;;
    -p|--profile)
      PROFILE="$2"
      if [[ "$PROFILE" != "code" && "$PROFILE" != "write" ]]; then
        echo "Error: --profile must be 'code' or 'write'"
        exit 1
      fi
      shift 2
      ;;
    -a|--agent)
      AGENT="$2"
      if [[ "$AGENT" != "cursor" && "$AGENT" != "claude" ]]; then
        echo "Error: --agent must be 'cursor' or 'claude'"
        exit 1
      fi
      if [[ "$AGENT" == "cursor" ]]; then
        AGENT=agent
      fi
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

# Validate required options
if [[ -z "$DIR" ]]; then
  echo "Error: -d <directory> is required"
  usage
  exit 1
fi

DIR=$(cd "$DIR" && pwd)
SESSION_NAME="${SESSION_NAME:-$(basename "$DIR")}"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session '$SESSION_NAME' already exists, attaching..."
else
  case "$PROFILE" in
    code)
      tmux new-session -d -c "$DIR" -s "$SESSION_NAME" -n "code"
      tmux send-keys -t "$SESSION_NAME:code" "nvim ." C-m
      tmux new-window -t "$SESSION_NAME" -n "shell" -c "$DIR"
      ;;
    write)
      tmux new-session -d -c "$DIR" -s "$SESSION_NAME" -n "write"
      tmux send-keys -t "$SESSION_NAME:write" "nvim ." C-m
      ;;
  esac

  if [[ -n "$AGENT" ]]; then
    tmux new-window -t "$SESSION_NAME" -n "$AGENT" -c "$DIR"
    tmux send-keys -t "$SESSION_NAME:$AGENT" "$AGENT" Enter
  fi
fi

# Attaching to window 1
# Default should be the actual workspace, nvim in code and writing profiles
exec tmux attach-session -t "$SESSION_NAME":1
