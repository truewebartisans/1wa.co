package main

import (
	"log"
	"net/http"

	"github.com/markbates/pkger"
)

func main() {
	static := pkger.Dir("/static")

	http.Handle("/", http.FileServer(static))

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
