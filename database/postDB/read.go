package pdb

import "net/http"

func ReadPostData() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {}
}
