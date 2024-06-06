# Reminders
- [ ] MacOS - krap keyboard stuff
    - tilde nightmare ˜ / ~ 
        - TODO: find another solution BR Legacy does not work with accents
        - Disable using US keyboard layout, is enables on US International layout
        - Disable using Brazilian Legacy keyboard layout, is enabled on Brazilian layout
    - " " "'Smart' Quotes" " " " ?
        - Disable on System Preferences -> Keyboard -> Text Input -> Edit -> Smart Quotes
- [ ] Color
    - [example_script](https://github.com/zzzeyez/colorlovers/blob/04d3ef65ff853f84004ad1136cdf90d4d7b7c819/colorlovers#L75)
- [ ] GIT
    - Delta as pager for other stuff see [hahuang65/git-config](https://github.com/hahuang65/git-config)
```gitconfig
[core]
  pager = delta
[delta "colorscheme"]
  commit-style                  = raw
  commit-decorations-style      = blue ol
  file-style                    = omit
  hunk-header-style             = file line-number
  hunk-header-decoration-style  = blue box
  hunk-header-file-style        = red
  hunk-header-line-number-style = red
  minus-style                   = bold red
  minus-non-emph-style          = red
  minus-emph-style              = bold black red
  minus-empty-line-marker-style = normal red
  zero-style                    = normal
  plus-style                    = bold green
  plus-non-emph-style           = green
  plus-emph-style               = bold black green
  plus-empty-line-marker-style  = normal green
  whitespace-error-style        = reverse purple
  true-color                    = always
  line-numbers-zero-style       = dim normal
  line-numbers-minus-style      = red
  line-numbers-plus-style       = green
  line-numbers-left-style       = blue
  line-numbers-right-style      = blue
[delta "interactive"]
  features = colorscheme
  keep-plus-minus-markers = false
[delta]
  features = colorscheme
  navigate = true
  side-by-side = true
[diff]
  submodule = log
  colorMoved = default
[interactive]
  diffFilter = delta --color-only --features=interactive
[pager]
  blame  = delta
  diff   = delta
  reflog = delta
  show   = delta
[merge]
  conflictstyle = diff3
```
- [ ] [cellular-automaton.nvim](https://github.com/Eandrju/cellular-automaton.nvim)
