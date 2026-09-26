#!/usr/bin/env bash


while true; do
    echo
    echo "=== SSH & Agent User Setup ==="
    echo "1) Generate SSH Key"
    echo "2) Set Agent User"
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
            # First, make the home directory not readable by others
            chmod 700 "$HOME"

            # Create the new agent user
            sudo sysadminctl -addUser agent \
              -fullName "Agent" \
              -password -

            # Define agent home directory
            AGENT_HOME = "/Users/agent"
            sudo mkdir "${AGENT_HOME}/.ssh"

            # Copy the new user ssh key to its home directory
            sudo cp "$HOME/.ssh/id_agent.pub" \
                "${AGENT_HOME}/.ssh/authorized_keys"

            # Adjust permissions
            sudo chown -R agent "${AGENT_HOME}/.ssh"
            sudo chmod 700 "${AGENT_HOME}/.ssh"
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
