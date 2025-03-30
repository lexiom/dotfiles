# Setting up pynvim with uv

```sh
# Run these commands on your terminal
uv venv ~/.local/share/pynvim/venv
uv pip install pynvim -p ~/.local/share/pynvim/venv
```

```lua
-- Add this to your init.lua
vim.g.python3_host_prog = '~/.local/share/pynvim/venv/bin/python3'
```
