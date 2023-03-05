package handler

import (
	"Project/Aesos/request"
	"Project/Aesos/service"
	"net/http"

	"github.com/gin-gonic/gin"
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

func(h *UserHandler) Login(c*gin.Context) {

	var request request.LoginRequest

	if err := c.BindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Invalid login request"})
		return
	}

	user, token, status, err := h.Service.Login(request)
	
	if err != nil {
		c.JSON(status, gin.H{
			"message" : err.Error(),
		})
		return
	}

	c.JSON(status, gin.H{
		"message" : "success",
		"user": user,
		"token": token,
	})
}

func (h *UserHandler) RegisterUser(c *gin.Context) {
	var request request.RegisterRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message" : "Invalid request Body",
		})
		return
	}

	status, err := h.Service.RegisterUser(request)
	
	if err != nil {
		c.JSON(status, gin.H{
			"message" : err.Error(),
		})
		return
	}

	c.JSON(status, gin.H{
		"message" : "User successfully registered !",
	})
	
}

