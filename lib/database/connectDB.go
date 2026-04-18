package main

import (
	"database/sql"
	"fmt"
	"log"

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

	http.HandlerFunc("/register", registerHandler(db))

	// test on web server
	log.Println("Server running on :8080")
	http.ListenAndServer(":8080", nil)
}
