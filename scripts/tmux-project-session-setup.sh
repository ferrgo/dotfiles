#!/usr/bin/env bash

set -euo pipefail

FATAL_TAG="\033[1;38;5;134mFATAL\033[0m"

command -v gum >/dev/null || { echo -e "$FATAL_TAG gum not installed"; exit 1; }
command -v tmux >/dev/null || { echo -e "$FATAL_TAG tmux not installed"; exit 1; }

log() {
    local level="$1"
    shift
    # Need to make sure $* are strings since some logs have `-d` for instance and that confuses gum log's own args parsing
    gum log -l $level -s -- "$*" ##-- "$*" -s -t rfc822 -l "$level"
}

# log levels: "none","debug","info","warn","error","fatal"

usage() {
  gum log -s -l info -- "Usage: $(basename "$0") -d <directory> [-s <session_name>] [-p code|write] [-g cursor|claude] [-n]"
  gum log -s -l info -- ""
  gum log -s -l info -- "Options:"
  gum log -s -l info -- "  -d, --directory <dir>        Project directory (required)"
  gum log -s -l info -- "  -s, --session <name>         Override session name (default: directory basename)"
  gum log -s -l info -- "  -p, --profile code|write     Session profile (default: code)"
  gum log -s -l info -- "      code:  opens nvim + shell windows"
  gum log -s -l info -- "      write: opens a single write window"
  gum log -s -l info -- "  -a, --attach                 Attach to the session after creating it (default: yes)"
  gum log -s -l info -- "  -n, --no-attach              Create the session but do not attach to it"
  gum log -s -l info -- "  -g, --agent cursor|claude    Start an agent window in the session"
  gum log -s -l info -- "  -h, --help                   Show this help message"
}

DIR=""
SESSION_NAME=""
AGENT=""
AGENT_WINDOW_NAME=""
AGENT_CMD=""
PROFILE="code"
ATTACH=1
ATTACH_SET=0
NO_ATTACH_SET=0

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
        log "error" "--profile must be 'code' or 'write'"
        exit 1
      fi
      shift 2
      ;;
    -n|--no-attach)
      NO_ATTACH_SET=1
      ATTACH=0
      shift
      ;;
    -a|--attach)
      ATTACH_SET=1
      ATTACH=1
      shift
      ;;
    -g|--agent)
      AGENT="$2"
      if [[ "$AGENT" != "cursor" && "$AGENT" != "claude" ]]; then
        log "error" "--agent must be 'cursor' or 'claude'"
        exit 1
      fi
      AGENT_WINDOW_NAME="$AGENT"
      AGENT_CMD=$([[ "$AGENT" == "cursor" ]] && echo "agent" || echo "$AGENT")
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      log "error" "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

if (( ATTACH_SET && NO_ATTACH_SET )); then
  log "error" "cannot specify both --attach and --no-attach"
  exit 1
fi

# Validate required options
if [[ -z "$DIR" ]]; then
  log "error" "-d <directory> is required"
  usage
  exit 1
fi

[[ -d "$DIR" ]] || { log "error" "Not a directory: $DIR"; exit 1; }
DIR=$(cd "$DIR" && pwd)
SESSION_NAME="${SESSION_NAME:-$(basename "$DIR")}"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  log "warn" "Session '$SESSION_NAME' already exists."
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

if (( ATTACH )); then
  if [[ -n "${TMUX:-}" ]]; then
    exec tmux switch-client -t "$SESSION_NAME:$TARGET_WINDOW"
  else
    exec tmux attach-session -t "$SESSION_NAME:$TARGET_WINDOW"
  fi
else
  log "info" "Session '$SESSION_NAME' created. Use 'tmux attach-session -t $SESSION_NAME' to attach."
fi
