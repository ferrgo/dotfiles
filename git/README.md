# Git config

Git config files

Main file [.gitconfig](./.gitconfig) includes other files based on current directory

```.gitconfig
[includeif "gitdir:~/path/to/workspace"]
    path = ~/path/to/git/profile.gitconfig
```

## SSH Config

Use the `insteadOf` key to set an alias for the host that can be configured on ssh config

Gitconfig:
```.gitconfig
[url "git@githut.com-work"]
  insteadOf = git@github.com
```

SSH Config
```sshconfig
Host github.com-work
  Hostname github.com
  User workuser 
  IdentityFile ~/.ssh/id_file_workuser_github
```

See [ssh](../ssh) for more
