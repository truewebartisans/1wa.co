---
date: "2019-09-16T20:10:00+0300"
title: "How to make git clone for my private repository on GitHub?"
description: ""
slug: how-to-git-clone-private-repository
weight: 1
toc: true
type:
  - post
  - posts
tags:
  - howto
  - VDS
  - git
  - private
  - repository
  - GitHub
series:
  - Use case
---

## Introduction

Welcome! This is another article in the “How to” series.

This time, we will try to do without magic!

### Objectives of the article

1. Show one of the easiest ways to clone your private GitHub repository;
2. Train your console skills;

## Let's clone it!

First, generate SSH key on your VDS:

```console
sudo ssh-keygen
```

> Choose any name if you want, I use default name of key: `rsa_key`.

Next step, create SSH config:

```bash
sudo cat >~/.ssh/config <<EOL

Host my_project
Hostname github.com
User git
IdentityFile ~/.ssh/rsa_key

EOL
```

And now, copy public key to clipboard:

```console
sudo cat ~/.ssh/rsa_key.pub
```

Go to your GitHub repository settings. Add copied public key to `Deploy Keys` section. That's it! You may git clone your private repository on VDS:

```console
sudo git clone my_project:<user>/<repo>.git
```

For update code from your repository, type into project directory:

```console
git pull
```

### Questions

1. What's console command may generate SSH key?
2. What does the `cat` attribute on console?
