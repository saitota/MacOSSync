# MacOS Syncronizer
setup tools for saito MacOS


setup task first
```
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin
```
see https://taskfile.dev/#get-the-binary


setup brew, tools and symlinks
```
task setup-macos
```

- Taskfile.yml
    - see `task --list-all` for details
- ~Makefile~ deprecated
- dotfiles/
    - my dotfiles like `.bashrc` to sync
    - sync them by using symlink
