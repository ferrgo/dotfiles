# SSH

## Multi accounts on same server

Use alias for the `Host` that point to same `Hostname` with different users

SSH Config
```sshconfig
Host github.com-work
  Hostname github.com
  User workuser 
  IdentityFile ~/.ssh/id_file_workuser_github
```

### Git

Use the `insteadOf` key to set an alias for the host that can be configured on ssh config

Gitconfig:
```.gitconfig
[url "git@githut.com-work"]
  insteadOf = git@github.com
```
