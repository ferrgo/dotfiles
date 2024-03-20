# Git config

Git config files

Main file [.gitconfig](./.gitconfig) includes other files based on current directory

```.gitconfig
[includeif "gitdir:~/path/to/workspace"]
    path = ~/path/to/git/profile/.gitconfig
```
