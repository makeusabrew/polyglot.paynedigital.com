package polyglot

import (
    "html/template"
    "fmt"
    "net/http"
)

func RouteRequests() func(w http.ResponseWriter, r *http.Request) {
    templates, err := template.ParseFiles("./templates/header.html", "./templates/home.html", "./templates/footer.html")
    if err != nil {
        fmt.Println("error - handle", err)
    }

    return func(w http.ResponseWriter, r *http.Request) {

        fmt.Println(r.Method, r.URL) // @TODO map method & URL to controller / action / template

        templates.ExecuteTemplate(w, "header.html", nil)
        templates.ExecuteTemplate(w, "home.html", nil)
        templates.ExecuteTemplate(w, "footer.html", nil)
    }
}
