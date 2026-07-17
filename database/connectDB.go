package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"
	auth "woc/database/auth"
	handler "woc/database/handler"
	pdb "woc/database/postDB"

	"net/http"

	"github.com/cloudinary/cloudinary-go/v2"
	"github.com/joho/godotenv"
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
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env")
	}

	connStr := os.Getenv("DATABASE_URL")

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		print("Error line 52.")
		panic(err)
	}

	fmt.Println("Connected to PostgresSQL!")

	http.HandleFunc("/register", handler.RegisterHandler(db))
	http.HandleFunc("/login", handler.LoginHandler(db))
	http.HandleFunc("/readUserPost", auth.AuthMiddelware(pdb.GetMyPost(db)))
	http.HandleFunc("/writeBack", auth.AuthMiddelware(pdb.WriteBack(db)))
	http.HandleFunc("/readAllPost", pdb.GetAllPost(db))
	http.HandleFunc("/logout", handler.LogoutHandler(db))
	http.HandleFunc("/refresh", handler.RefreshHandler(db))

	http.ListenAndServe(":8080", nil)

	srv := &http.Server{Addr: ":8080"}

	go func() {
		fmt.Println("Server running on :8080")
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatal(err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGABRT, syscall.SIGTERM)
	<-quit

	fmt.Println("Shutting down...")

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal("Force shutdown", err)
	}

	fmt.Println("Server closed cleanly")
}
