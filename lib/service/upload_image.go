package service

import (
	"context"
	"encoding/json"
	"net/http"

	"github.com/cloudinary/cloudinary-go/v2"
	"github.com/cloudinary/cloudinary-go/v2/api"
	"github.com/cloudinary/cloudinary-go/v2/api/uploader"
)

func UploadImage(cld *cloudinary.Cloudinary, ctx context.Context, w http.ResponseWriter, r *http.Request) {
	file, _, err := r.FormFile("image")
	if err != nil {
		http.Error(w, "Cannot read file", 400)
		return
	}

	defer file.Close()

	resp, err := cld.Upload.Upload(ctx, file, uploader.UploadParams{
		UniqueFilename: api.Bool(true),
	})
	if err != nil {
		http.Error(w, "Upload failed", 500)
		return
	}

	// json style
	json.NewEncoder(w).Encode(map[string]string{
		"image_url": resp.SecureURL,
	})

	// fmt style
	//fmt.Fprintln(w, resp.SecureURL)
}
