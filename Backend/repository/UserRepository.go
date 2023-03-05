package repository

import (
	"Project/Aesos/constants"
	"Project/Aesos/model"
	"errors"

	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type UserRepository interface {
	GetUserList() ([]model.User, error)
	GetUserByUsernameAndPassword(username string, password string) (*model.User, error)
	RegisterUser(user model.User) (error)
}

type userRepository struct {
	db *gorm.DB
}

func NewUserRepository(db *gorm.DB) *userRepository {
	return &userRepository{db}
}

func(r *userRepository) GetUserList() ([]model.User, error) {
	var user []model.User

	getAllUser := r.db.Find(&user)

	if getAllUser.Error != nil {
		return nil, getAllUser.Error
	}

	user = append([]model.User{}, user...)

	return user, nil
}

func (r *userRepository) GetUserByUsernameAndPassword(username string, password string) (*model.User, error) {
	var user model.User
	
	getUser := r.db.Where("username=?",username).Find(&user)

	if getUser != nil {
		if err := bcrypt.CompareHashAndPassword(user.Password, []byte(password)); err == nil {
			user.Password = nil
			return &user, nil
		} else {
			return nil, errors.New(constants.ErrorNoUser)
		}
	}

	if getUser.Error != nil {
		return nil, getUser.Error
	}

	return &user, nil
}

func (r *userRepository) RegisterUser(user model.User) (error) {

	result := r.db.Create(&user)

	if result.Error != nil {
		return result.Error
	}

	return nil
}