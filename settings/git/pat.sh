#!/usr/bin/env bash

printf 'protocol=https\nhost=github.com\nusername=github_username\npassword=github_pat\n\n' \
  | git credential-store --file ~/.config/git/credentials store
