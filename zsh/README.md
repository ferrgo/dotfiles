# ZSH Dotfile
All config files for zsh.

Inspired by [Phantas0s/.dotfiles](https://github.com/Phantas0s/.dotfiles/tree/master/zsh). See [Configuring Zsh Without dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

# ZSH Config Files
1. $ZDOTDIR/.zshenv
2. $ZDOTDIR/.zprofile
3. $ZDOTDIR/.zshrc
4. $ZDOTDIR/.zlogin
5. $ZDOTDIR/.zlogout

# ZSH Config Path
By default `ZSH` looks at the `$HOME` directory for this files, the `$ZDOTDIR` can be used to change this behavior

At `$HOME/.zshenv` there should be a file such as:

```bash
## Define dotdir
export ZDOTDIR="${ZDOTDIR:-"$HOME/path/to/zsh/dot/files"}"
## Source real env file
source $ZDOTDIR/.zshenv
```

This will ensure `ZSH` looks to the correct directory and that a full `.zshenv` can be stored at the same directory, keeping configs out of this dir minimal

# Profiles
Still under design.

Edit the `$HOME/.zshenv` file to set the `ZDOTDIR` to the correct path and source the `.zshenv` file
