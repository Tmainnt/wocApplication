package pdb

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	auth "woc/database/auth"
)

type Post struct {
	PostID          int    `json:"post_id"`
	UserID          string `json:"user_id"`
	Content         string `json:"post_content"`
	Image           string `json:"post_image"`
	CreateTimestamp string `json:"create_timestamp"`
	UpdateTimestamp string `json:"update_timestamp"`
	PostVisibility  string `json:"post_visibility"`
	PostStatus      string `json:"post_status"`
	LikeCount       int    `json:"like_count"`
	CommentCount    int    `json:"comment_count"`
}

func GetAllPost(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		row, err := db.Query(`SELECT post_id_pk, user_id_pk, post_content, post_image, create_timestamp, update_timestamp, post_status, like_count, comment_count FROM posts WHERE post_visibility = "public"`)
		if err != nil {
			http.Error(w, "Error fetch data", 500)
		}

		defer row.Close()

		var post []Post
		for row.Next() {
			var p Post
			row.Scan(&p.PostID, &p.UserID, &p.Content, &p.Image, &p.CreateTimestamp, &p.UpdateTimestamp, &p.PostVisibility, &p.PostStatus, &p.LikeCount, &p.CommentCount)
			post = append(post, p)
		}
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(post)
	}
}

func GetMyPost(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		claims := r.Context().Value("user").(*auth.Claims)
		var userID int
		err := db.QueryRow(`SELECT user_id FROM users WHERE user_email = $1`, claims.Email).Scan(&userID)
		if err != nil {
			if err == sql.ErrNoRows {
				http.Error(w, "User not found", 400)
				return
			}
			http.Error(w, "Database Error", 500)
			log.Println(err)
			return
		}

		row, err := db.Query(`SELECT post_id, user_id_pk, post_content, post_image, create_timestamp, update_timestamp FROM post WHERE user_id_pk = $1`, userID)

		if err != nil {
			http.Error(w, "Error fetch data", 500)
			return
		}

		defer row.Close()

		var posts []Post

		for row.Next() {
			var p Post
			row.Scan(&p.PostID, &p.UserID, &p.Content, &p.Image, &p.CreateTimestamp, &p.UpdateTimestamp)
			posts = append(posts, p)
		}

		json.NewEncoder(w).Encode(posts)
	}
}
