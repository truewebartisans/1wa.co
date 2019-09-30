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

Welcome! The “How to” series continue. Today, we busted huge problem with GitHub: clone private repository to VDS.

### Objectives of the article

1. Show one of the easiest ways to clone your private GitHub repository;
2. Train your console skills;

## Prepare setup

First, generate SSH key on your VDS:

```console
sudo ssh-keygen
```

> Choose any name, if you want. I use default name `id_rsa` and dir `~/.ssh`.

```console
Generating public/private rsa key pair.

Enter file in which to save the key (~/.ssh/id_rsa): <file name>

Enter passphrase (empty for no passphrase): <password>
Enter same passphrase again: <password again>

Your identification has been saved in ~/.ssh/id_rsa.
Your public key has been saved in ~/.ssh/id_rsa.pub.

The key fingerprint is:
SHA256:Hs516tDZPzK0b+/cQhNiyWZUJwnaeDqOShMBBQidhBX user@vds.local

The key's randomart image is:
+---[RSA 2048]----+
|.o.o  **E=       |
|=*ooo..          |
|  o.+ .          |
|   = .           |
|  o   . S      ..|
|     o..o .......|
|    ..** o....o. |
|      oo   o+o==.|
|     .o.+.   . o=|
+----[SHA256]-----+
```

Next step, create SSH config:

```bash
sudo cat >~/.ssh/config <<EOL

Host my_project
Hostname github.com
User git
IdentityFile ~/.ssh/id_rsa

EOL
```

And now, copy public key to clipboard:

```console
sudo cat ~/.ssh/rsa_key.pub
```

Go to your GitHub repository settings. Add copied public key to `Deploy Keys` section.

![GitHub Deploy Keys section](https://user-images.githubusercontent.com/11155743/65852734-bdf72600-e35f-11e9-900d-d8ca0f58b29e.png)

> Don't forget check `Allow write access`. That's it!

## Let's clone it!

You may git clone your private repository on VDS:

```console
sudo git clone my_project:<user>/<repo>.git
```

## How to update?

For update code from your repository, type into project directory:

```console
git pull
```

### Questions

1. What's console command may generate SSH key?
2. What does the `cat` command on console?
3. What happens, if you run command on console without `sudo`?
