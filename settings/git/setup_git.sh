#!/usr/bin/env bash
set -euo pipefail

echo -e "\nGit Configurator\n"
echo -e "1. Create user gitconfig"
echo -e "2. Set gitconfig owned paths"
echo -e "3. Set default git editor (nvim)\n"
read -rp "Option: " OPTION

case "${OPTION}" in
  "1")
    echo -e ""
    read -rp "Git config name: " CONFIG
    read -rp "Git user name: " NAME
    read -rp "Git user email: " EMAIL
    
    git config --file ./gitconfig-"${CONFIG}" user.name "${NAME}"
    git config --file ./gitconfig-"${CONFIG}" user.email "${EMAIL}"
    git config --file ./gitconfig-"${CONFIG}" url.git@github-${CONFIG}:.insteadOf "git@github.com:"
    ;;
  "2")
    echo -e ""
    read -rp "Git config name: " CONFIG
    read -rp "Git config owned path: " USER_PATH 

    CFG_PATH="~/.config/git/${CONFIG}/.gitconfig"

    git config --file gitconfig-main --add "includeIf.gitdir:${USER_PATH}/.path" "${CFG_PATH}"
    ;;
  "3")
    git config --file gitconfig-main core.editor nvim
    ;;
  *)
    echo -e "\nInvalid option!\n"
    ;;
esac
