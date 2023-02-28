package handler

import (
	"Project/Aesos/service"
	"fmt"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

type UserHandler struct {
	Service service.UserService
}

func NewUserHandler(service service.UserService) *UserHandler {
	return &UserHandler{service}
}

func (h *UserHandler) GetUserList(c* gin.Context) {
	user, status, err := h.Service.GetUserList()

	if err != nil {
			c.JSON(status, gin.H{
				"message": err.Error(),
			})
			return
	}

	c.JSON(status, gin.H{
		"message" : "success",
		"user": user,
	})
}

func(h *UserHandler) GetUserByUsernameAndPassword(c*gin.Context) {

	password := []byte("password")

	hashedPassword, err := bcrypt.GenerateFromPassword(password, bcrypt.DefaultCost)

	if err != nil {
        panic(err)
    }
    fmt.Println(string(hashedPassword))

	user, status, err := h.Service.GetUserByUsernameAndPassword("ricardosuyanto", "password")

	if err != nil {
		c.JSON(status, gin.H{
			"message" : err.Error(),
		})
		return
	}

	c.JSON(status, gin.H{
		"message" : "success",
		"user": user,
	})
}
