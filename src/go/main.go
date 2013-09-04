package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Hello go!");
}

func main() {
    http.HandleFunc("/", handler)

    err := http.ListenAndServe(":8081", nil)

    if err != nil {
        fmt.Println("ListenAndServe error", err)
    }
}
