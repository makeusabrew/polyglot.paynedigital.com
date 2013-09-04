package main

import (
    "fmt"
    "net/http"
    // bad practice, but not sure how to organise go code when it's out
    // of its usual habitat
    "./pkg/polyglot"
)

func main() {
    http.HandleFunc("/", polyglot.RouteRequests())
    http.Handle("/assets", http.FileServer(http.Dir("../../public")))

    err := http.ListenAndServe(":8081", nil)

    if err != nil {
        fmt.Println("ListenAndServe error", err)
    }
}
