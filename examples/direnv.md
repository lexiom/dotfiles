# direnv

1. Inside a project, create a .envrc file:

```sh
# ~/project-root
touch .envrc
```

2. Then add `use flake .` to it:

```sh
# ~/project-root/.envrc
use flake .
```

You can add the `--impure` flag to cache reevaluations:

```sh
# ~/project-root/.envrc
use flake . --impure
```

3. Finally, allow direnv to load your nix flake:

```sh
# ~/project-root
direnv allow
```
