#!/usr/bin/env bash

app="$1"
monitors="$(aerospace list-monitors --count)"

case "$app:$monitors" in
  Ghostty:1)  workspace=1 ;;
  Chromium:1) workspace=2 ;;
  Finder:1)   workspace=3 ;;
  Music:1)    workspace=4 ;;

  Ghostty:*)  workspace=1 ;;
  Chromium:*) workspace=1 ;;
  Finder:*)   workspace=2 ;;
  Music:*)    workspace=2 ;;
esac

[ -z "$workspace" ] && exit 0
aerospace move-node-to-workspace "$workspace"
