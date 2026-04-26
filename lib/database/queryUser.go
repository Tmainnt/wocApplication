package main

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"golang.org/x/crypto/bcrypt"
)

type loginRequest struct {
	Req_Email    string `json:"user_email"`
	Req_Password string `json:"user_pass"`
}

type User struct {
	Name     string `json:"user_name"`
	Password string `json:"user_pass"`
	Email    string `json:"user_email"`
	FName    string `json:"first_name"`
	LName    string `json:"last_name"`
	Gender   string `json:"user_gender"`
	DOF      string `json:"date_of_birth"`
	PhoneNB  string `json:"phone_number"`
}

func loginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req loginRequest
		var user User
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			http.Error(w, "Invalid json", 400)
			return
		}

		if req.Req_Email == "" || req.Req_Password == "" {
			http.Error(w, "Email and password required", 400)
		}

		err = db.QueryRow(
			"SELECT user_email, user_name FROM users WHERE user_email=$1",
			req.Req_Email,
		).Scan(
			&user.Email, &user.FName)

		if err != nil {
			if err == sql.ErrNoRows {
				http.Error(w, "User not found	", 400)
				return
			}
			http.Error(w, "Database Error", 500)
		}

		err = bcrypt.CompareHashAndPassword([]byte(user.Password),
			[]byte(req.Req_Password))

		if err != nil {
			http.Error(w, "Wrong Password", 401)
			return
		}

		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Login Successful"))
	}
}
