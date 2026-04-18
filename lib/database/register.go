import (
	"database/sql"
	"encoding/json"
	"net/http"
	"golang.org/x/crypto/bcrypt"
)

type RegisterRequest struct {
	Name String `json:"user_name"`
	Password String `json:"user_pass"`
	Email String `json:"user_email"`
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

		err = db.Exec(
			"INSERT INTO users(user_name, user_pass, user_email) VALUES($1, $2, $3)",
			req.Email,
			string(hashed),
		)

		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}

		w.WriteHeader(http.StatusCreated)
		w.Write([]byte("register success"))
	}
}