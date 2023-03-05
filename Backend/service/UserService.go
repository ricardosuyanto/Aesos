package service

import (
	"Project/Aesos/middleware"
	"Project/Aesos/model"
	"Project/Aesos/repository"
	"Project/Aesos/request"
	"net/http"

	"golang.org/x/crypto/bcrypt"
)

type UserService interface {
	GetUserList() ([]model.User, int, error)
	Login(request.LoginRequest) (*model.User, string, int, error)
	RegisterUser(request.RegisterRequest) (int, error)
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

func (s *userService) Login(request request.LoginRequest) (*model.User, string, int, error) {
	user, err := s.Repo.Login(request)

	if err != nil {
		return nil, "", http.StatusInternalServerError, err
	}

	token, err := middleware.CreateToken(request.Username)

	if err != nil {
		return nil, "", http.StatusInternalServerError, err
	}

	return user, token, http.StatusOK, nil
}

func (s *userService) RegisterUser(request request.RegisterRequest) (int, error) {

	var user model.User

	hashedPassword, errorHash := bcrypt.GenerateFromPassword([]byte(request.Password), bcrypt.DefaultCost)

	if errorHash != nil {
		return http.StatusInternalServerError, errorHash
	}

	user.Password = hashedPassword
	user.Email =  request.Email
	user.Username = request.Username

	err := s.Repo.RegisterUser(user)

	if err != nil {
		return http.StatusInternalServerError, err
	}

	return http.StatusOK, nil
}




