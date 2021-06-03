# 🚀 Installation

To recursively get all submodules on clone:

```bash
git clone --recurse-submodules https://github.com/scotttesler/dotfiles.git ~/.dotfiles
~/.dotfiles/install
```

If you already cloned the project but need to get new submodules:

```bash
git submodule update --init --recursive
```

To update all submodules to their latest commits:

```bash
git submodule update --recursive --remote
```
