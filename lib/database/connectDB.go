package db

import (
	"database/sql"
	"fmt"

	"net/http"

	_ "github.com/lib/pq"
)

func main() {
	connStr := "user=postgres password=Reyzaburrel123@ dbname=myapp sslmode=disable"

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Connected to PostgresSQL!")

	http.HandleFunc("/register", registerHandler(db))
	http.HandleFunc("/loging", loginHandler(db))

	http.ListenAndServe(":8080", nil)
}
