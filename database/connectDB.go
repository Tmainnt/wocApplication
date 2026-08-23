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

	"context"

	"github.com/cloudinary/cloudinary-go/v2"
	"github.com/joho/godotenv"

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

	db.SetMaxIdleConns(10)
	db.SetMaxOpenConns(50)
	db.SetConnMaxIdleTime(5 * time.Minute)
	db.SetConnMaxLifetime(30 * time.Minute)

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Connected to PostgresSQL!")

	mux := http.NewServeMux()
	mux.HandleFunc("/register", handler.RegisterHandler(db))
	mux.HandleFunc("/login", handler.LoginHandler(db))
	mux.HandleFunc("/readUserPost", auth.AuthMiddelware(pdb.GetMyPost(db)))
	mux.HandleFunc("/writeBack", auth.AuthMiddelware(pdb.WriteBack(db)))
	mux.HandleFunc("/readAllPost", pdb.GetAllPost(db))
	mux.HandleFunc("/logout", handler.LogoutHandler(db))
	mux.HandleFunc("/refresh", handler.RefreshHandler(db))

	srv := &http.Server{
		Addr:         ":8080",
		Handler:      mux,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	http.ListenAndServe(":8080", nil)

	go func() {
		fmt.Println("Server running on :8080")
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Server error: %v", err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt, syscall.SIGABRT, syscall.SIGTERM)
	<-quit

	fmt.Println("Shutting down...")

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal("Force shutdown", err)
	}

	fmt.Println("Server closed cleanly")
}
