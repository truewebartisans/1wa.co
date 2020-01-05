package main

import (
	"log"
	"net/http"

	"github.com/markbates/pkger"
)

func main() {
	static := pkger.Dir("/static")

	http.Handle("/", http.FileServer(static))

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
