package service

import (
	"Project/Aesos/model"
	"Project/Aesos/repository"
	"net/http"
)

type UserService interface {
	GetUserList() ([]model.User, int, error)
	GetUserByUsernameAndPassword(username string, password string) (*model.User, int, error)
}

type userService struct {
	Repo repository.UserRepository
}

func NewUserService(repo repository.UserRepository) *userService {
	return &userService{repo}
}

func (s *userService) GetUserList() ([]model.User, int, error) {
	user, err := s.Repo.GetUserList()

	if err != nil {
		return nil, http.StatusInternalServerError, err
	}

	return user, http.StatusOK, nil
}

func (s *userService) GetUserByUsernameAndPassword(username string, password string) (*model.User, int, error) {
	user, err := s.Repo.GetUserByUsernameAndPassword(username, password)

	if err != nil {
		return nil, http.StatusInternalServerError, err
	}

	return user, http.StatusOK, nil
}



