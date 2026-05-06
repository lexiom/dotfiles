# dotfiles

## Step 1: Install Xcode Command Line Tools

Open a terminal window and simply try to run git:

```sh
git
```

Once you execute it, macOS should prompt you to install Xcode Command Line Tools.

## Step 2: Set up GitHub credentials

Copy your ssh keys to your new system:

```sh
cp /backup_source/.ssh/* ~/.ssh
```

Set up your git configuration:

```sh
# Run the git_setup script
./git_setup

# Export the GIT_CONFIG_GLOBAL env
export GIT_CONFIG_GLOBAL=~/.config/git/.gitconfig
```

## Step 3: Applying the configuration

Install [nix-darwin](https://github.com/nix-darwin/nix-darwin).

Apply the dotfiles configuration:

```sh
git clone git@github.com:lexiom/dotfiles.git
cd dotfiles
sudo darwin-rebuild switch --flake .#macos
```

## Extra: Generate a list of available nix-darwin options on macOS

```sh
nix eval --json '.#darwinConfigurations.macos.options' | jq . > options.json
```
