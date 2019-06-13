---
date: "2019-05-30T23:10:00+0300"
title: "Creating a native macOS app on Golang and React.js with full code protection (without magic)"
description: "Creating a native macOS app on Golang and React.js with full code protection (without magic)"
slug: native-macos-app-on-golang-and-react
weight: 1
toc: true
type:
  - post
  - posts
tags:
  - howto
  - golang
  - reactjs
  - macos
  - native app
series:
  - Use case
---

## Introduction

Welcome to the next article in the “How to” series! This time, we will analyze the creation of a native desktop application for macOS, write a little code on Golang and React.js, which will have copy protection.

This time, we will try to do without magic!

### Objectives of the article

1. Show one of the easiest ways to create a native desktop application for macOS on Golang;
2. Show the option to protect the code of your application from being modified by third parties (for example, during commercial distribution);

## Instruments

### Work Environment

- Go `1.12.5`;
- Node.js `12.3.1`;

### Operating system

- Apple macOS `10.14.5` Mojave (darwin/amd64);

### Package and Dependency Manager

- dep `0.5.3` (Golang);
- npm `6.9.0` (Node.js);

## Used Golang Packages

- `net/http` - standard package for creating a web server ([godoc](https://golang.org/pkg/net/http/));
- `gobuffalo/packr` - package for packaging all the necessary sources into one executable binary file ([GitHub](https://github.com/gobuffalo/packr));
- `zserge/webview` - cross-platform package for creating a native operating system window with a built-in browser ([GitHub](https://github.com/zserge/webview));

## Used Node.js libraries

- `facebook/create-react-app` - front-end for macOS-application ([GitHub](https://github.com/facebook/create-react-app));
- `axios/axios` - for easier writing of AJAX requests ([GitHub](https://github.com/axios/axios));

## Theoretical base

To better understand what is happening, I suggest you examine the work of some of the packages on which we will rely and use.

### net/http

A package that provides an implementation of the HTTP client and server. Included in the standard Go delivery and does not require separate installation and configuration.

It is interesting to us, as it is very easy to understand, has good documentation and has the function `http.FileServer()`.

For more details, see [official documentation](https://golang.org/pkg/net/http/#pkg-overview).

#### http.FileServer()

This function is the key and gives the web server full access to the specified folder and all its files. That is, the `http.FileServer()` function allows you to mount a folder to any specified address (route) of the web server.

For example, mount the root folder `./static/images/photos` so that it is available at `http://localhost:8000/photos`:

```go
http.Handle("/photos", http.FileServer("./static/images/photos"))
```

### gobuffalo/packr

Package with a talking title. It is he who will allow us to pack all the necessary files into one binary file.

> Please note that the article describes how to work with the `v1` branch.

Suppose we have the following project directory structure:

```text
tree .

├── main.go
└── templates
    ├── admin
    │   └── index.html
    └── index.html
```

The file `./main.go` contains:

```go
package main

import (
	"fmt"

	"github.com/gobuffalo/packr"
)

func main() {
	// Folder, with templates that are needed
	// add to binary file (pack)
	box := packr.NewBox("./templates")

	// We search file inside the folder
	s, err := box.FindString("admin/index.html")

	// If file is not found, then error
	if err != nil {
		log.Fatal(err)
	}

	// Display file content
	fmt.Println(s)
}
```

Now let's compile the project into an executable binary file. At the same time, the `packr` package will pack the entire contents of the`./templates` folder into it:

```powershell
packr build ./main.go
```

If you want to create a binary file for an OS or architecture other than the one you are working with now, then call `packr` like this:

```powershell
# Example for GNU/Linux, x64 bit
GOOS=linux GOARCH=amd64 packr build ./main.go
```

### zserge/webview

A tiny cross-platform web-browsing package used to create modern graphical interfaces.

> Please note that the article describes how to work with the version `0.1.0`.

The file `./main.go` contains:

```go
package main

import "github.com/zserge/webview"

func main() {
	// Open the Google homepage in a window with a size of 1024x768 px,
	// without resizing the window
	webview.Open("Google", "https://google.com", 1024, 768, false)
}
```

To create a macOS application, go to the console and execute:

```powershell
# Creating directory structure of a macOS app
mkdir -p example.app/Contents/MacOS

# Compile ./main.go to app folder
go build -o example.app/Contents/MacOS/example

# Run app
open example.app
```

## Structure of macOS application

```text
tree .

├── vendor
├── ui
│   ├── build
│   ├── node_modules
│   ├── public
│   ├── src
│   ├── package-lock.json
│   └── package.json
├── helloworld.app
├── Gopkg.lock
├── Gopkg.toml
└── main.go
```

### Description of main files and folders

- `vendor` — all packages installed using `dep` will be stored here;
- `ui` — folder with React.js application (frontend);
  - `build` — folder with production-version of React-app after the build;
  - `src` — folder with the source code of the React-app;
  - `package.json` — dependency file `npm`;
- `helloworld.app` — macOS application (specially prepared folder);
- `Gopkg.toml` — dependency file `dep`;
- `main.go` — Golang application source code (backend);

## Write the code

Enough theory. As he said, without exaggeration, one of the great programmers of our time, Linus Torvalds:

> Talk is cheap. Show me the code.
>
> — Linus Torvalds

Let's follow this advice and write some code.

I will not analyze each line of code separately, as I consider it redundant and counter-productive. All code listings are provided with detailed comments.

### Memo for beginners/copy-paste developers

Great, when there is a full code listing at the end of the article, right? You can immediately, without reading the text, copy all the program code and see its execution ...

At this point, I would like to appeal to all readers who do not want to spend time on theory:

> Do not mindlessly copy code from the Internet! This will not help you (in understanding the code and subject of the article), nor the author (in explaining/helping in the comments).

### Frontend for application

React.js is a powerful, but at the same time, easy-to-learn JavaScript-library for creating user interfaces, which is perfect for us to implement the frontend part of the application.

> For this article, we **will not** use anything but the standard “It works!” React.js page.

Like everything in modern frontend, we start with the installation of React.js and all the necessary auxiliary libraries.

```powershell
# Create a folder for app and go into it
mkdir ~/helloworld_project && cd ~/helloworld_project

# According to the structure of finished app,
# install React.js in ./ui directory
npx create-react-app ui

# Go to folder and check that everything works
cd ui && npm start && open http://localhost:3000

# Next, stop dev server (press Ctrl+C)
# and install axios library
npm i --save axios
```

#### Code listing of the ./ui/src/App.js file

```jsx
// Импортируем React и методы хуков
import React, { useState, useEffect } from "react";

// Импортируем библиотеку axios
import axios from "axios";

// Импортируем логотип и CSS
import logo from "./logo.svg";
import "./App.css";

function App() {
  // Определяем хранилище для полученных данных
  const [state, setState] = useState([]);

  // Retrieving data from an AJAX request.
  // Remember that the function passed to useEffect will run,
  // after render is fixed on the screen.
  // See https://reactjs.org/docs/hooks-reference.html#useeffect
  useEffect(() => {
    axios
      .get("/hello") // GET request to URL /hello
      .then(resp => setState(resp.data)) // save response to state
      .catch(err => console.log(err)); // catch error
  });

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>Hello, {state.text}!</p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
```

That's all, the frontend for the application is ready! 👌
