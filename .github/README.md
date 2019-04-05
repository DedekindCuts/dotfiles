# dotfiles
Personal configuration and settings files for macOS.
Managed by [yadm](https://yadm.io).

## Introduction

### Dotfiles in general
For a very helpful explainer of what dotfiles are, read Lars Kappert's [Getting Started With Dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789).
You can see examples of other dotfiles [here](https://dotfiles.github.io), and examples of dotfiles managed by yadm [here](https://yadm.io/docs/examples).

### This repository
My dotfiles include: 
* [shell customizations](../.dotfiles/shell) (including aliases, PATH settings, and a customized prompt and color scheme)
* [git settings](../.gitconfig)
* [macOS settings](../.dotfiles/macos-settings) (thanks to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles))
* [Homebrew](https://brew.sh) [Brewfiles](../.dotfiles/brew) for easy installation of desired programs (including App Store apps through [MAS](https://github.com/mas-cli/mas))
* [text editor settings and customizations](../.dotfiles/editors)
* [R](https://www.r-project.org/) [settings](../.Rprofile)
* a [list of programs](../.dotfiles/installs) to install manually (in case unavailable through Homebrew, Homebrew Cask, or MAS)
* [lists](../.dotfiles/macos-settings/) specifying the apps and folders on the Dock
* a [bootstrap](../.yadm/bootstrap) script for installing from the Brewfiles and applying the macOS and editor settings
* [profile files](../.yadm/profiles) for specifying different dotfile configurations (see [Customization](#customization) below)

## Usage

### Customization
These dotfiles are customized to my personal needs.
This means that you should not simply clone these dotfiles as they are (unless you're me.)
Instead, feel free to fork this repository and make changes according to your needs.

To make this easy (and also because sometimes I need different dotfile configurations for different situations), a large amount of customization can be done through [profiles](../.yadm/profiles). 
These are shell scripts that set the [yadm class](https://yadm.io/docs/alternates#), specify whether to install certain tools (like Homebrew and Conda), and indicate whether the user has admin privileges.
You can easily make one of these according to your own needs using the existing [profiles](../.yadm/profiles) as a template.

Further customizations can be made by using yadm's classes (see [here](https://yadm.io/docs/alternates#).)
For example, if I create a profile named "Something" in which the yadm class is set to "Something", then when I run the bootstrap script it will offer to apply the [macOS settings](../.dotfiles/macos-settings) specified in the file "macos##Something", if it exists. 
If a file named for the current yadm class does not exist, or if the yadm class is not set, then it will use the file with no class name ("macos##) by default.

The recommended workflow for customizing these dotfiles is as follows:
1. fork this repository
2. `git clone` the forked repository (not to your $HOME directory yet)
3. create a new profile in [.yadm/profiles](../.yadm/profiles), customized to your needs
    * make sure to name the yadm class set in the new profile file (I recommend giving it the same name as the profile)
4. customize each file as needed
    * if there are any files of which you may want to have different versions on different systems, then create a customized version with "##" and the yadm class name associated with that profile appended to the filename (for example, I have different versions of [gitconfig-local](../.dotfiles/git-settings) for personal and work use)
    * otherwise (if you want to change the file from what I have, but you will not want or need to have different versions on different systems), just edit the file as-is and don't include "##" or any class names in the filename (for example, I use the same [bash_prompt](../.dotfiles/shell/bash_prompt) on all my machines)
5. commit your changes to your forked repository
6. follow the [installation instructions](#installation) below

I also recommend browsing other dotfiles repositories ([here](https://dotfiles.github.io) and [here](https://yadm.io/docs/examples)) for ideas and inspiration on how to further customize your dotfiles.

### Installation
For a fresh install on a new computer, use the [fresh install script](../.yadm/fresh.sh) that will install yadm and use it to set everything up:

```bash
# if you're me
bash <(curl -fsSL https://raw.github.com/DedekindCuts/dotfiles/master/.yadm/fresh.sh)

# if you've forked and customized this repository
bash <(curl -fsSL [url of fresh.sh within your forked repository])
```

Otherwise:
1. [Install yadm](https://yadm.io/docs/install) (assuming it's not already installed)
2. Remove any currently-existing dotfiles that may cause conflicts
3. Clone this repository using yadm: 

```bash
# if you're me
yadm clone git@github.com:DedekindCuts/dotfiles.git --bootstrap

# if you've forked and customized this repository
yadm clone [url of your forked repository] --bootstrap
```

## Other
[Licensed under the MIT License](LICENSE.txt)
