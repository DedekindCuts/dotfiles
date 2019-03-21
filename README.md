# dotfiles
Personal configuration and settings files, together with an install script for easy setup on a new machine

## Introduction
For a very helpful introduction to dotfiles, read Lars Kappert's [Getting Started With Dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789).
The dotfiles in this repository are customized to my personal preference (obviously), so I would suggest using them as inspiration or as a starting point for your own dotfiles rather than just copying them.
You can also see a lot of other (often more extensive) dotfile collections and suggestions [here](https://dotfiles.github.io).

## Getting Started

### Prerequisites
These files are intended for use with macOS.
Other than that there are no prerequisites.

### Usage
My initial goal for this project was to have a way of quickly setting up a new machine with my preferences, ideally with one command that I could memorize.
This can be accomplished as follows:
```bash
bash <(curl -L https://raw.github.com/DedekindCuts/dotfiles/master/install.sh)
```

However, this will not work for anyone else, since these files are customized to my personal preferences and also rely on my Apple ID to download apps from the App Store that I have already purchased.

If you would like to use these dotfiles as a starting point for your own, you should first fork this repository.
Once you have forked your own copy of this repository, you will need to make the following changes:

1. Edit `install.sh`, changing `USER` to your own GitHub username and `REPO` to the name of your copy of this repository, `APPLE_ID` to your own Apple ID, and possibly changing `DIR` to the location where you would like to store your dotfiles. (**Note**: if you do change `DIR`, you will also need to edit `dots/bash_profile` to change the definition of `alias updateDotfiles` appropriately so that the alias points to the actual location of your dotfiles.) Also you will need edit `dots/gitconfig` to set your Git username and email to your own instead of mine.
2. If you do not use (and do not want to use) Sublime Text, remove the lines referencing Sublime from the end of `install.sh`. If this is the case, you can also delete the folder `Sublime` from your copy of this repository.
3. If you do use Sublime, replace the folder `Sublime/User/` in your copy of this repository with a copy of your own Sublime `user` folder (contained in `/Users/{user}/Library/Application Support/Sublime Text 3/Packages`.)
3. Edit `Brewfile` to contain only the programs that you want to have installed on your computer. If you already use Homebrew, you could replace this with your own Brewfile(s). Just make sure that the names of your Brewfile(s) match the ones referenced in `install.sh`.
4. If you would like to use the selective install option, make sure to edit `mas_list` to contain any App Store apps that you would like to install on any of your machines. If you already use [mas](https://github.com/mas-cli/mas), you can create your own version of this file as follows: 
	```bash
	mas list > mas_list
	```
5. Finally, edit the files in `dots/` to your liking.
	* `bash_profile`: contains custom Terminal aliases, functions, etc.
	* `bash_prompt`: specifies a custom Terminal prompt (copied from [Mathias Bynen's dotfiles](https://github.com/mathiasbynens/dotfiles))
	* `gitconfig`: Git settings
	* `gitignore_global`: global list of patterns describing files that Git should not track
	* `macos`: MacOS preferences (many of these were taken from [Mathias Bynen's dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.macos))
	* `Rprofile`: custom settings for R (feel free to delete if you don't use R)
	* `solarized_dark.terminal`: custom terminal theme (also taken from [Mathias Bynen's dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/init/Solarized%20Dark%20xterm-256color.terminal))
6. Add any other dotfiles that you like. You can find more suggestions and inspiration [here](https://dotfiles.github.io) and [here](https://github.com/dotphiles/dotphiles).

Once you have made all these changes, you can install all your dotfiles and all of the programs referenced in your Brewfile(s) by running the install script and following the prompts:
```bash
source install.sh
```

Once the dotfiles have been installed, you can easily update and reapply them with
```bash
updateDotfiles
```

## Credits
`dots/bash_prompt`, `dots/macos`, and `dots/solarized_dark.terminal` were all copied, with very little editing, from [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles).

> Copyright Mathias Bynens <https://mathiasbynens.be/>
> 
> Permission is hereby granted, free of charge, to any person obtaining
> a copy of this software and associated documentation files (the
> "Software"), to deal in the Software without restriction, including
> without limitation the rights to use, copy, modify, merge, publish,
> distribute, sublicense, and/or sell copies of the Software, and to
> permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
> 
> The above copyright notice and this permission notice shall be
> included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
> LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
> OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
> WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.