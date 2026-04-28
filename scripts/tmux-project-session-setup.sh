#!/usr/bin/env bash

set -euo pipefail

command -v tmux >/dev/null || { echo "tmux not installed"; exit 1; }

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
      AGENT_WINDOW_NAME="agent"
      AGENT_CMD=$([[ "$AGENT" == "cursor" ]] && echo "agent" || echo "claude")
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

# Validate required options
if [[ -z "$DIR" ]]; then
  echo "Error: -d <directory> is required"
  usage
  exit 1
fi

[[ -d "$DIR" ]] || { echo "Not a directory: $DIR"; exit 1; }
DIR=$(cd "$DIR" && pwd) || exit 1
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
    tmux new-window -t "$SESSION_NAME" -n "$AGENT_WINDOW_NAME" -c "$DIR"
    tmux send-keys -t "$SESSION_NAME:$AGENT_WINDOW_NAME" "$AGENT_CMD" C-m
  fi
fi

TARGET_WINDOW="$PROFILE"  # "code" or "write"

if [[ -n "${TMUX:-}" ]]; then
  exec tmux switch-client -t "$SESSION_NAME:$TARGET_WINDOW"
else
  exec tmux attach-session -t "$SESSION_NAME:$TARGET_WINDOW"
fi
