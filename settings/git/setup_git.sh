#!/usr/bin/env bash
set -euo pipefail

GIT_DIR="${HOME}/.config/git"

echo -e "\nGit Configurator\n"
echo -e "1. Single user git configuration"
echo -e "2. Multi user git configuration"

echo ""
read -rp "Option: " OPTION

case "${OPTION}" in
  "1")
    echo ""
    read -rp "Git config name: " CONFIG
    read -rp "Git user name: " NAME
    read -rp "Git user email: " EMAIL
    
    git config --file ./gitconfig "user.name" "${NAME}"
    git config --file ./gitconfig "user.email" "${EMAIL}"
    git config --file ./gitconfig "url.git@github-${CONFIG}:.insteadOf" "git@github.com:"
    git config --file ./gitconfig "core.editor" "nvim"

    rm -rf "${GIT_DIR}" && \
        mkdir "${GIT_DIR}" && \
        mv ./gitconfig "${GIT_DIR}/.gitconfig"

    echo -e "\nUser ${NAME} configured successfully!\n"
    ;;
  "2")
    echo ""
    read -rp "Number of git users: " NUM_USERS
    echo ""

    rm -rf "${GIT_DIR}" && \
        mkdir "${GIT_DIR}"

    for ((i = 1; i <= NUM_USERS; i++)); do
        read -rp "Git config name: " CONFIG
        read -rp "Git user name: " NAME
        read -rp "Git user email: " EMAIL
        read -rp "User-owned path: " USR_PATH

        git config --file "./gitconfig-${CONFIG}" "user.name" "${NAME}"
        git config --file "./gitconfig-${CONFIG}" "user.email" "${EMAIL}"
        git config --file "./gitconfig-${CONFIG}" "url.git@github-${CONFIG}:.insteadOf" "git@github.com:"

        mkdir "${GIT_DIR}/${CONFIG}" && \
            mv "./gitconfig-${CONFIG}" "${GIT_DIR}/${CONFIG}/.gitconfig"

        CFG_PATH="${GIT_DIR}/${CONFIG}/.gitconfig"
        git config --file ./gitconfig-main --add "includeIf.gitdir:${USR_PATH}/.path" "${CFG_PATH}"

        echo -e "\nUser ${NAME} configured successfully!\n"
    done

    git config --file ./gitconfig-main "core.editor" "nvim"
    mv ./gitconfig-main "${GIT_DIR}/.gitconfig"
    ;;
  *)
    echo -e "\nInvalid option!\n"
    ;;
esac
