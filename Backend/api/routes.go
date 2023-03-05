package api

import (
	"Project/Aesos/handler"
	"Project/Aesos/middleware"
	"Project/Aesos/repository"
	"Project/Aesos/service"

	"github.com/gin-gonic/gin"
)

func (s *server) SetUpRouter() {
	// s.Router.Use(cors.New(cors.Config{
	// 	AllowOrigins: []string{"*"},
	// 	AllowMethods: []string{"POST", "GET", "DELETE", "PUT", "PATCH"},
	// 	AllowHeaders: []string{"*"},
	// }))
	userRepo := repository.NewUserRepository(s.DB)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(userService)

	s.Router.GET("/findUser", middleware.AuthMiddleware(), func(c *gin.Context){
		userHandler.GetUserList(c)
	})
	s.Router.POST("/login", userHandler.Login)

	s.Router.POST("/registerUser", userHandler.RegisterUser)
}