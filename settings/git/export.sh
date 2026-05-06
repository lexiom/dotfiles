#!/usr/bin/env bash

GIT_PATH="${HOME}/.config/git"

rm -rf "${GIT_PATH}"

mkdir "${GIT_PATH}"
mkdir "${GIT_PATH}"/personal
mkdir "${GIT_PATH}"/work

mv gitconfig-main "${GIT_PATH}/.gitconfig"
mv gitconfig-personal "${GIT_PATH}/personal/.gitconfig"
mv gitconfig-work "${GIT_PATH}/work/.gitconfig"
