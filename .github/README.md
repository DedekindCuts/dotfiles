# dotfiles
Personal configuration and settings files for MacOS.
Managed by [yadm](https://yadm.io).

## Introduction

### Dotfiles in general
For a very helpful explainer of what dotfiles are, read Lars Kappert's [Getting Started With Dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789).
You can see examples of other dotfiles [here](https://dotfiles.github.io), and examples of dotfiles managed by yadm [here](https://yadm.io/docs/examples).

### This repository
My dotfiles include: 
* [shell customizations](../.shell) (including aliases, PATH settings, and a customized prompt and color scheme)
* [git settings](../.gitconfig)
* [macOS settings](../.macos-settings/.macos) (thanks to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles))
* [Homebrew](https://brew.sh) [Brewfiles](../.brew) for easy installation of desired programs (including App Store apps through [MAS](https://github.com/mas-cli/mas))
* [VS Code](https://code.visualstudio.com/) [settings](../.vscode-settings), custom keybindings, snippets, and installed extensions
* [R](https://www.r-project.org/) [settings](../.Rprofile)
* a [bootstrap](../.yadm/bootstrap) script for installing from the Brewfiles and applying the macOS and VS Code settings

## Usage

### Before proceeding
These dotfiles are customized to my personal needs, and in some cases ([.gitconfig](../.gitconfig), for example) actually contain my personal information.
This means that you should not simply clone these dotfiles as they are (unless you're me.)
Instead, feel free to fork this repository and make changes according to your needs.
I also recommend browsing other dotfiles repositories ([here](https://dotfiles.github.io) and [here](https://yadm.io/docs/examples)) for ideas and inspiration.

If you do fork this repository, make the following changes AT MINIMUM before applying them:
* Change the name, email, and GitHub username in [.gitconfig](../.gitconfig) and [.git-settings/.gitconfig.local](../.git-settings/.gitconfig.local##Veracity)
* Change the language and text formats and timezone in [.macos-settings/.macos](../.macos-settings/.macos) as necessary
* Change DOTFILES_REPO in [.yadm/fresh.sh](../.yadm/fresh.sh) to the url of your modified repository

### Installation
For a fresh install on a new computer, use the [one-and-done install script](../.yadm/fresh.sh) that will install yadm and use it to set everything up:

```bash
bash <(curl -L https://raw.github.com/DedekindCuts/new-dotfiles/master/.yadm/fresh.sh)
```

Otherwise:
1. [Install yadm](https://yadm.io/docs/install) (assuming it's not already installed)
2. Remove any currently-existing dotfiles that may cause conflicts
3. Clone this repository using yadm: 

```bash
yadm clone git@github.com:DedekindCuts/new-dotfiles.git --bootstrap
```

## Other
[License](LICENSE)
