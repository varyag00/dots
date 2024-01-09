# Dotfiles

This is a collection of my dotfiles, which are managed using [chezmoi](https://www.chezmoi.io/).

## Usage

To install the dotfiles on a new machine:

```sh
chezmoi init --apply --verbose https://github.com/varyag00/dots.git
```


To see which dotfiles are managed:

```sh
chezmoi managed
```

To update the dotfiles from the remote repo:

```sh
chezmoi update
```

To view the local diff:

```sh
chezmoi diff
```

To update the dotfiles using local changes, there are a few options:

```sh
# --- editing in the dotfiles _repo_ ---

# 1. edit the dotfiles repo directly in this directory, in default editor
chezmoi edit

# 2. use `chezmoi cd` to cd into the dotfiles directory, edit the files directly, then `chezmoi apply` to apply the managed changes
chezmoi apply

# --- edit the dotfiles $HOME dir ---

# 3. edit the dotfiles in $HOME, then run
chezmoi add $FILE
# or
chezmoi re-add $FILE

# 4. edit the dotfiles in $HOME, then run
chezmoi merge $FILE
```
