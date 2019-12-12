package main

import (
	"net/http"

	"github.com/markbates/pkger"
)

func main() {
	pkger.Include("/static")
	static := pkger.Dir("/static")

	http.Handle("/", http.FileServer(static))

	http.ListenAndServe(":8080", nil)
}
