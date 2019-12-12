package main

import (
	"net/http"

	"github.com/markbates/pkger"
)

func main() {
	static := pkger.Dir("/static")
	http.Handle("/", http.FileServer(static))
	http.ListenAndServe(":8080", nil)
}
