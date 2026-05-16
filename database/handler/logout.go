package handler

import (
	"database/sql"
	"net/http"
	"time"
	auth "woc/database/auth"
)

func LogoutHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		claims := r.Context().Value(auth.UserContextKey).(*auth.Claims)

		db.Exec(`DELETE FROM refresh_token WHERE user_id_fk = $1`, claims.UserID)

		db.Exec(`UPDATE users SET status = 'Offline' WHERE user_id = $1`, claims.UserID)

		// Clear cookie
		http.SetCookie(w, &http.Cookie{
			Name:     "refresh_token",
			Value:    "",
			HttpOnly: true,
			Expires:  time.Unix(0, 0),
			MaxAge:   -1,
			Path:     "/refresh",
		})

		w.WriteHeader(http.StatusOK)
		w.Write([]byte("logged out"))
	}
}
