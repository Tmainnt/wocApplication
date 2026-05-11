package main

import (
	"database/sql"
	"fmt"
	auth "woc/database/auth"
	handler "woc/database/handler"
	pdb "woc/database/postDB"

	"net/http"

	"github.com/cloudinary/cloudinary-go/v2"

	//"github.com/cloudinary/cloudinary-go/v2/api"
	//"github.com/cloudinary/cloudinary-go/v2/api/admin"
	//"github.com/cloudinary/cloudinary-go/v2/api/uploader"
	"context"

	_ "github.com/lib/pq"
)

func credentials() (*cloudinary.Cloudinary, context.Context) {
	cld, _ := cloudinary.New()
	cld.Config.URL.Secure = true
	ctx := context.Background()
	return cld, ctx
}

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
	http.HandleFunc("/readUserPost", auth.AuthMiddelware(pdb.GetMyPost(db)))
	http.HandleFunc("/writeBack", auth.AuthMiddelware(pdb.WriteBack(db)))
	http.HandleFunc("/readAllPost", pdb.GetAllPost(db))

	http.ListenAndServe(":8080", nil)
}
