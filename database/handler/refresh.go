package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"
	auth "woc/database/auth"

	"golang.org/x/crypto/bcrypt"
)

func RefreshHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// 1. อ่าน refresh token จาก cookie
		cookie, err := r.Cookie("refresh_token")
		if err != nil {
			http.Error(w, "No refresh token", 401)
			return
		}
		refreshToken := cookie.Value

		// 2. parse และ verify JWT signature + expiry
		claims, err := auth.ParseRefreshToken(refreshToken)
		if err != nil {
			http.Error(w, "Invalid token", 401)
			return
		}

		if claims.TokenType != "RefreshToken" {
			http.Error(w, "Invalid token type", 401)
			return
		}

		// 3. ตรวจสอบกับ DB ว่ายังมีอยู่และไม่หมดอายุ
		var hashedToken string
		err = db.QueryRow(`
            SELECT token FROM refresh_token
            WHERE user_id_fk = $1 AND expires_timestamp > NOW()`,
			claims.UserID,
		).Scan(&hashedToken)

		if err != nil {
			http.Error(w, "Token not found", 401)
			return
		}

		// 4. เปรียบเทียบ hash
		err = bcrypt.CompareHashAndPassword([]byte(hashedToken), []byte(refreshToken))
		if err != nil {
			http.Error(w, "Token mismatch", 401)
			return
		}

		// 5. ออก access token ใหม่ (Role เก็บไว้ใน DB หรือ query เพิ่ม)
		var role string
		db.QueryRow(`SELECT role FROM users WHERE user_id = $1`, claims.UserID).Scan(&role)

		newAccessToken, err := auth.GenerateAccessToken(claims.UserID, claims.Email, role)
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
