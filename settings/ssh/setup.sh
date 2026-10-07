#!/usr/bin/env bash


while true; do
    echo
    echo "=== SSH & Agent User Setup ==="
    echo "1) Generate SSH Key"
    echo "2) Create Unprivileged User"
    echo "q) Quit"
    echo

    read -rp "Choose an option: " CHOICE

    case "${CHOICE}" in
        1)
            read -rp "SSH key name: " KEY_NAME
            ssh-keygen -t ed25519 \
              -f "~/.ssh/id_${KEY_NAME}" \
              -C "${KEY_NAME}@macos"
            ;;
        2)
            read -rp "User name: " USERNAME

            # First, make the home directory not readable by others
            chmod 700 ${HOME}

            # Create the new agent user
            sudo sysadminctl -addUser ${USERNAME} \
              -fullName ${USERNAME} \
              -password -

            # Define agent home directory
            USER_HOME = "/Users/${USERNAME}"
            sudo mkdir "${USER_HOME}/.ssh"

            # Copy the new user ssh key to its home directory
            sudo cp "${HOME}/.ssh/id_agent.pub" \
                "${USER_HOME}/.ssh/authorized_keys"

            # Adjust permissions
            sudo chown -R agent "${USER_HOME}/.ssh"
            sudo chmod 700 "${USER_HOME}/.ssh"
            ;;
        q|Q)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid option: ${CHOICE}"
            ;;
    esac
done
