# vim-config
For synchronization purposes.

## Correct clone command
From home directory:
`git clone https://github.com/d86leader/vim-config .vim`

## Make nvim symlinks
`bash .vim/install-nvim.sh`

## Now also incluldes dotfiles
Install with `bash .vim/install-dotfiles.sh`

## For all installs above
`bash .vim/install.sh`

## Bash autocompletions
They go into `.local/share/bash-completion/completions/`

Instructions for my most common:
- `stack --bash-completion-script stack > stack`
- `rustup completions bash > rustup`
- `rustup completions bash cargo > cargo`
