package repository

import (
	"Project/Aesos/model"

	"gorm.io/gorm"
)

type UserRepository interface {
	GetUserList() ([]model.User, error)
	GetUserByUsernameAndPassword(username string, password string) (*model.User, error)
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

	getUser := r.db.Where("username=? AND password=? ",username,password).Take(&user)

	if getUser.Error != nil {
		return nil, getUser.Error
	}

	return &user, nil
}