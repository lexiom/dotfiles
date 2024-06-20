if status is-interactive
    and not set -q TMUX
    exec tmux
end

starship init fish | source
source "$HOME/.cargo/env.fish"
