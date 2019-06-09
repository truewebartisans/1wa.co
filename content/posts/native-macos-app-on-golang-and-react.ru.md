---
date: "2019-05-30T23:10:00+0300"
title: "Создание нативного десктоп приложения для macOS на Golang и React.js с полной защитой кода (без магии)"
description: "Создание нативного десктоп приложения для macOS на Golang и React.js с полной защитой кода (без магии)"
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

## Введение

Добро пожаловать в очередную статью из цикла «How to»! На этот раз, у нас будет

### Цели статьи

1. Показать один из самых простых способов создания нативного десктоп приложения для macOS на Golang с использованием React.js;
2. Показать вариант защиты кода вашего приложения от изменения третими лицами (например, при коммерческом распространении);

### Рабочее окружение

- Golang `1.12.5`;
- Node.js `12.3.1`;

> В качестве ОС, я использую Apple macOS `10.14.5` Mojave (darwin/amd64).

#### Система контроля пакетов

- dep `0.5.3` (Golang);
- npm `6.9.0` (Node.js);

#### Пакеты Golang

- `net/http` — стандартный пакет для создания веб-сервера;
- `gobuffalo/packr` — пакет для упаковки всех необходимых исходников в один бинарный (исполняемый) файл;
- `zserge/webview` — кроссплатформенный пакет для создания нативного окна операционной системы со встроенным браузером;

#### Пакеты Node.js

- `create-react-app` — в качестве фронтенда для macOS-приложения;
- `axios` — для более простого написания AJAX-запросов;

## Теоритическая база

Чтобы лучше понять происходящее, предлагаю вам изучить работу некоторых пакетов, на которые мы будем опираться и использовать.

### net/http

Пакет, который обеспечивает реализацию HTTP клиента и сервера. Входит в состав стандартной поставки Golang и не требует отдельной установки и настройки.

Он интересен нам, так как очень прост в понимании, имеет хорошую документацию и обладает функцией `http.FileServer()`.

> Более подробно, читайте в [официальной документации](https://golang.org/pkg/net/http/#pkg-overview).

#### http.FileServer()

Эта функция является ключевой и даёт полный доступ веб-серверу к указанной папке и всем её файлам. То есть, функция `http.FileServer()` позволяет смонтировать папку на любой указанный адрес (route) веб-сервера.

Например, смонтируем корневую папку `./static/images/photos` так, чтобы она была доступна по адресу `http://localhost:8000/photos`:

```go
http.Handle("/photos", http.FileServer("./static/images/photos"))
```

### gobuffalo/packr

> Обратите внимание, что в статье описана работа с версией `2.2.0`.

### zserge/webview

> Обратите внимание, что в статье описана работа с версией `0.1.0`.

## Пишем код

Хватит теории. Как говорил, без преувеличения, великий программист нашего времени Линус Торвальдс:

> Talk is cheap. Show me the code.

Давайте последуем этому совету и напишем немного кода, чтобы закрепить материал.

### Памятка для начинающих/copy-paste разработчиков

Отлично, когда есть полный листинг кода в конце статьи, правда? Можно сразу же, не вчитываясь в текст, скопировать весь код программы и посмотреть её выполнение..

На этом моменте, я хотел бы сразу же обратиться ко всем читателям, которые не хотят тратить время на теорию:

> Не копируйте бездумно код из Интернета! Это не поможет ни вам (в понимании кода и предмета статьи), ни автору (при объяснии/помощи в комментариях).

### Структура готового приложения

```text
$ tree .

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

### Полный листинг кода ./main.go

```go
package main

import (
	"encoding/json"
	"net/http"

	"github.com/gobuffalo/packr"
	"github.com/zserge/webview"
)

// Message : struct for message
type Message struct {
	Text string `json:"text"`
}

func main() {
	// Bind folder path for packaging with Packr
	folder := packr.NewBox("./static/build")

	// Handle to ./static/build folder on root path
	http.Handle("/", http.FileServer(folder))

	// Handle to showMessage func on /hello path
	http.HandleFunc("/hello", showMessage)

	// Run server at port 8000 as goroutine
	// for non-block working
	go http.ListenAndServe(":8000", nil)

	// Let's open window app with:
	//  - name: Golang App
	//  - address: http://localhost:8000
	//  - sizes: 800x600 px
	//  - resizable: true
	webview.Open("Golang App", "http://localhost:8000", 800, 600, true)
}

func showMessage(w http.ResponseWriter, r *http.Request) {
	// Create Message JSON data
	message := Message{"World"}

	// Return JSON encoding to output
	output, err := json.Marshal(message)

	// Catch error, if it happens
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// Set header Content-Type
	w.Header().Set("Content-Type", "application/json")

	// Write output
	w.Write(output)
}
```

## Кросс-компиляция для Windows и GNU/Linux

Теоритический блок и приведённый в статье код — являются актуальными для разработки подобного приложения для других ОС. При этом, код остаётся неизменным.

> Пиши код один раз — запускай везде!

Это становится возможным, благодаря кросс-системной природе Golang. Вы можете с лёгкостью скомпилоровать исполняемый файл вашего приложения для запуска на любой поддерживаемой операционной системе:

- GNU/Linux — исполняемый бинарный файл;
- Windows — исполняемый файл `.exe`;
- macOS — бинарный файл, расположенный внутри приложения `.app`;

Мы рассмотрим это в следующих статьях. **Следите за обновлениями!**
