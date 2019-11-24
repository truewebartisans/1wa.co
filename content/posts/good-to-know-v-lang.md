---
date: "2019-11-24T10:10:00+0300"
title: "The V programming language"
description: ""
slug: good-to-know-v-lang
weight: 1
toc: true
type:
  - post
  - posts
tags:
  - v
  - vlang
  - programing language
series:
  - Good to know
---

## Introduction

Hello! I'm starting “Good to know” series. And now, I so excited to show you very yong, but simple, fast, safe & compiled programming language called **V** (or **vlang** for Google Search bots).

### Objectives of the article

1. Story of V;
2. Hello World;
3. Main features of language;
4. How to install and update;

## What's "V" mean?

No, [Alexander Medvednikov](https://github.com/medvednikov) (author of V programming language) do not fan of "V for Vendetta" movie. But it's very interesting story:

> Initially the language had the same name as the product it was created for: Volt. The extension was ".v", I didn't want to mess up git history, so I decided to name it V :)
>
> It's a simple name that reflects the simplicity of the language, and it's easy to pronounce for everyone in the world.
>
> — Alexander Medvednikov

## The V's "Hello World"!

```go
// hello_world.v

fn main() {
  w := 'World'
  println('Hello $w!')
}
```

Clear and simple, uh? What if I tell you that this code can be written in even shorter form? If your program is only single file (all code in one file), V allows you to drop `fn main() {...}`. Like this:

```go
// hello_world.v

w := 'World'
println('Hello $w!')
```

Yes, this is a valid V code too!

## Main features

### V is written in V

The entire language and its standard library are less than 1 MB and can be built in less than 0.6 seconds.

V compiles between ≈100k and 1.2 million lines of code per second per CPU core (without hardware optimization).

### As fast as C

Minimal amount of allocations, plus built-in serialization without runtime reflection. Compiles to native binaries without any dependencies.

### Safety

- No: null, global variables, variable shadowing and undefined values + behavior;
- Yes: bounds checking, option/result types, generics;
- By default: immutable variables + structs, pure functions;

### Similar to another languages

If you work with C, Go, Rust or JavaScript, you're ready to write code on V! Don't trust me, read program code near and answer "what each line do?":

```go
import time
import http

fn main() {
  resp := http.get('https://vlang.io/utc_now') or {
    println('failed to fetch data from the server')
    return
  }

  t := time.unix(resp.text.int())
  println(t.format())
}
```

This program go to external HTTP server, return UNIX timestamp or print `failed ...`. Next, we set to `t` variable normalized date and time by standard V library `time` and print result. Simple to read, easy to write!

### Build-in package manager

The V Package Manager ([vpm](https://vpm.best/)) — it's package management tool similar to NPM by Node.js.

```console
v install [module]
```

### Plugins for V syntax on popular code editors

1. [VS Code](https://marketplace.visualstudio.com/items?itemName=0x9ef.vscode-vlang&ssr=false)
2. [Vim](https://github.com/ollykel/v-vim)
3. [Vid](https://github.com/vlang/vid) (1 MB editor written in V)

## Prepare and install V

Okay, time to try V on your computer!

> Because I work only on macOS, I show installation process only for this OS. Windows users, sorry...

First, go to console and clone V repository:

```console
git clone https://github.com/vlang/v
```

Next, go to v folder and run `make`:

```console
cd v
make
```

That's all. V was installed to `/usr/local/bin/v` path.

### Update V

For update V to latest version, simply type `/usr/local/bin/v up` on console.

## More about V language

- GitHub repository — [https://github.com/vlang/v](https://github.com/vlang/v)
- Official docs — [https://vlang.io/docs](https://vlang.io/docs)

### Fresh news

- Twitter — [https://twitter.com/v_language](https://twitter.com/v_language)
- Telegram — [EN](https://t.me/vlang_en), [RU](https://t.me/vlang_ru), [IT](https://t.me/vlang_it), [ZH](https://t.me/vlang_zh)

## Exercises

1. Find in V official web site comparison to other languages;
2. Go to official V [Playground](https://vlang.io/play) and write some code;
3. Install V on your computer, go to `example` folder on GitHub repository and run "Game of life";
