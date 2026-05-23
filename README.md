# macOS Setup 

## Install Xcode Command Line Tools

Open a terminal window and simply try to run git:

```sh
git
```

Once you execute it, macOS should prompt you to install Xcode Command Line Tools.

## Set up GitHub credentials

Copy your ssh keys to your new system:

```sh
cp /backup_source/my_ssh_key ~/.ssh
```

Clone the dotfiles repo:

```sh
git clone git@github.com:lexiom/dotfiles.git
cd dotfiles
```

Set up your git configuration:

```sh
# Run the git_setup script
./setup_git.sh
```

## Apply the configuration

Install [nix-darwin](https://github.com/nix-darwin/nix-darwin).

Apply the dotfiles configuration:

```sh
sudo darwin-rebuild switch --flake .#macos
```

## Extra: Generate a list of available nix-darwin options on macOS

```sh
nix eval --json '.#darwinConfigurations.macos.options' | jq . > options.json
```
