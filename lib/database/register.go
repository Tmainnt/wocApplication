package db

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"golang.org/x/crypto/bcrypt"
)

type RegisterRequest struct {
	Name     string `json:"user_name"`
	Password string `json:"user_pass"`
	Email    string `json:"user_email"`
	FName    string `json:"first_name"`
	LName    string `json:"last_name"`
	Gender   string `json:"user_gender"`
	DOF      string `json:"date_of_birth"`
	PhoneNB  string `json:"phone_number"`
}

func registerHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req RegisterRequest
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			http.Error(w, "Invalid json", 400)
			return
		}

		if req.Name == "" || req.Email == "" || req.Password == "" {
			http.Error(w, "Email and password required", 400)
		}

		hashed, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
		if err != nil {
			http.Error(w, "Hash error", 500)
			return
		}

		_, err = db.Exec(
			"INSERT INTO users(user_name, user_pass, user_email, first_name, last_name, user_gender, date_of_birth, phone_number) VALUES($1, $2, $3, $4, $5, $6, $7, $8)",
			req.Name,
			string(hashed),
			req.Email,
			req.FName,
			req.LName,
			req.Gender,
			req.DOF,
			req.PhoneNB,
		)

		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}

		w.WriteHeader(http.StatusCreated)
		w.Write([]byte("register success"))
	}
}
