package pdb

import (
	"database/sql"
	"encoding/json"
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
	ReportCount     int    `json:"report_count"`
}

func GetAllPost(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		row, err := db.Query(`SELECT post_id_pk, user_id_pk, post_content, post_image, create_timestamp, update_timestamp, post_status, like_count, comment_count FROM posts WHERE post_visibility = 'public'`)
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
		claims := r.Context().Value(auth.UserContextKey).(*auth.Claims)

		row, err := db.Query(`SELECT post_id, user_id_pk, post_content, post_image, like_count, comment_count, report_count, create_timestamp, update_timestamp FROM post WHERE user_id_pk = $1`, claims.UserID)

		if err != nil {
			http.Error(w, "Error fetch data", 500)
			return
		}

		defer row.Close()

		var posts []Post

		for row.Next() {
			var p Post
			row.Scan(&p.PostID, &p.UserID, &p.Content, &p.Image, &p.LikeCount, &p.CommentCount, &p.ReportCount, &p.CreateTimestamp, &p.UpdateTimestamp)
			posts = append(posts, p)
		}

		json.NewEncoder(w).Encode(posts)
	}
}
