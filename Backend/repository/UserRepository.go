package repository

import (
	"Project/Aesos/model"

	"gorm.io/gorm"
)

type UserRepository interface {
	GetUserList() ([]model.User, error)
	GetUserByUsernameAndPassword(username string, password string) ([]model.User, error)
}

type repository struct {
	db *gorm.DB
}

func(r *repository) GetUserList() ([]model.User, error) {
	var user []model.User

	return user, nil
}