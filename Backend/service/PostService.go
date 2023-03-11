package service

import (
	"Project/Aesos/model"
	"Project/Aesos/repository"
	"Project/Aesos/request"
	"encoding/base64"
	"net/http"
)

type PostService interface {
	MakePost(request request.PostRequest) (int, error)
	GetPostList() ([]model.Post, int, error)
}

type postService struct {
	Repo repository.PostRepository
}

func NewPostService(repo repository.PostRepository) *postService {
	return &postService{repo}
}

func (s *postService) MakePost(request request.PostRequest) (int, error) {

	pictureData, err := base64.StdEncoding.DecodeString(request.Picture)

	if err != nil {
		return http.StatusBadRequest, err
	}

	var post model.Post

	post.Title = request.Title
	post.Description = request.Description
	post.Picture = pictureData

	var user model.User

	user.Id = request.UserID

	post.User_id = user.Id

	err = s.Repo.MakePost(post)

	if err != nil {
		return http.StatusInternalServerError, err
	}

	return http.StatusOK, nil

}

func (s *postService) GetPostList() ([]model.Post, int, error) {

	posts, err := s.Repo.GetPostList()

	if err != nil {
		return nil, http.StatusInternalServerError, err
	}

	return posts, http.StatusOK, nil
}