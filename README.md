# My Playdate Template Repo

Forked from
[SquidGodDev/playdate-template](https://github.com/SquidGodDev/playdate-template). 

Customized for my personal preferences and constantly updating as I get more familiar with Playdate development. 

## `new-project.sh`

As I refine my workflow I'll probably keep this script tracked in the repo or something, but I keep this at the top of the directory where I keep all my Playdate project repos:

```sh
#!/usr/bin/env bash

if [[ $# < 1 ]]; then
    echo 'Usage: new-project.sh [project-directory-name]'
    exit 1
fi

git clone https://github.com/connordelacruz/playdate-template.git "$1"
rm -rf "$1/README.md" "$1/.git"
git -C "$1" init
git -C "$1" add .
git -C "$1" commit -am "Initial commit."
```

This takes the new project's desired directory name as an argument, clones this template, deletes the README and .git, then initializes a new git repo and does an initial commit.
