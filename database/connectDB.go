package db

import (
	"database/sql"
	"fmt"
	auth "woc/database/auth"
	handler "woc/database/handler"
	pdb "woc/database/postDB"

	"net/http"

	_ "github.com/lib/pq"
)

func main() {
	connStr := "user=postgres password=Reyzaburrel123@ dbname=postgres sslmode=disable"

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

	http.HandleFunc("/register", handler.RegisterHandler(db))
	http.HandleFunc("/login", handler.LoginHandler(db))
	http.HandleFunc("/readPost", auth.AuthMiddelware(pdb.ReadPostData()))

	http.ListenAndServe(":8080", nil)
}
