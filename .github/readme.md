# my `.dotfiles`

### Deployment

```bash
git clone --bare https://github.com/zohnannor/.dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no # optional
```

#### TODO

- [ ] somehow add `/etc` configs because I want to have them VCS-ed
