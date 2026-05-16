package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"
	auth "woc/database/auth"

	"golang.org/x/crypto/bcrypt"
)

type RefreshRequest struct {
	RefreshToken string `json:"refresh_token"`
}

func RefreshHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req RefreshRequest
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			http.Error(w, "Invalid request", 400)
			return
		}

		claims, err := auth.ParseToken(req.RefreshToken)
		if err != nil {
			http.Error(w, "Invalid token", 401)
			return
		}

		if claims.TokenType != "RefreshToken" {
			http.Error(w, "Invalid token type", 401)
			return
		}

		var hashedToken string

		err = db.QueryRow(`
			SELECT token FROM refresh_token
			WHERE user_id_fk = $1
			AND expires_timestamp > NOW()`, claims.UserID).Scan(&hashedToken)

		if err != nil {
			http.Error(w, "Token not found", 401)
			return
		}

		err = bcrypt.CompareHashAndPassword(
			[]byte(hashedToken),
			[]byte(req.RefreshToken),
		)

		if err != nil {
			http.Error(w, "Token not match", 401)
			return
		}

		newAccessToken, err := auth.GenerateAccessToken(claims.UserID, claims.Email, claims.Role)
		if err != nil {
			http.Error(w, "Cannot generate token", 500)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{
			"access_token": newAccessToken,
		})
	}
}
