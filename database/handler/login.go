package handler

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	auth "woc/database/auth"
	"golang.org/x/crypto/bcrypt"
)

type loginRequest struct {
	Req_Email    string `json:"user_email"`
	Req_Password string `json:"user_pass"`
}

type User struct {
	Name     string `json:"user_name"`
	Password string `json:"-"`
	Email    string `json:"user_email"`
	FName    string `json:"first_name"`
	LName    string `json:"last_name"`
	Gender   string `json:"gender"`
	DOF      string `json:"date_of_birth"`
	PhoneNB  string `json:"phone_number"`
	Role     string `json:"role"`
}

func LoginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req loginRequest
		var user User
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			http.Error(w, "Invalid json", 400)
			log.Println(err)
			return
		}

		if req.Req_Email == "" || req.Req_Password == "" {
			http.Error(w, "Email and password required", 400)
			log.Println(err)
			return
		}

		err = db.QueryRow(
			`SELECT user_name, user_email, gender, date_of_birth, phone_number, user_pass, role 
	 FROM users WHERE user_email=$1`,
			req.Req_Email,
		).Scan(
			&user.Name,
			&user.Email,
			&user.Gender,
			&user.DOF,
			&user.PhoneNB,
			&user.Password,
			&user.Role,
		)

		if err != nil {
			if err == sql.ErrNoRows {
				http.Error(w, "User not found	", 400)
				log.Println(err)
				return
			}
			http.Error(w, "Database Error", 500)
			log.Println(err)
			return
		}

		err = bcrypt.CompareHashAndPassword(
			[]byte(user.Password),
			[]byte(req.Req_Password))

		if err != nil {
			http.Error(w, "Wrong Password", 401)
			log.Println(err)
			return
		}

		token, err := auth.GenerateToken(user.Email, user.Role)

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"message": "success",
			"token":   token,
			"user":    user,
		})
	}
}
