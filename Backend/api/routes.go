package api

import (
	"Project/Aesos/handler"
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

	s.Router.GET("/findUser", func(c *gin.Context){
		userHandler.GetUserList(c)
	})
	s.Router.GET("/findUserByUsernameAndPassword", userHandler.GetUserByUsernameAndPassword)

}