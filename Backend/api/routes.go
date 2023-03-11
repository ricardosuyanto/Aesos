package api

import (
	"Project/Aesos/handler"
	"Project/Aesos/middleware"
	"Project/Aesos/repository"
	"Project/Aesos/service"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func (s *server) SetUpRouter() {
	s.Router.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"POST", "GET", "DELETE", "PUT", "PATCH"},
		AllowHeaders: []string{"*"},
	}))
	userRepo := repository.NewUserRepository(s.DB)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(userService)

	s.Router.GET("/findUser", middleware.AuthMiddleware(), func(c *gin.Context) {
		userHandler.GetUserList(c)
	})
	s.Router.POST("/login", userHandler.Login)

	s.Router.POST("/registerUser", userHandler.RegisterUser)

	postRepo := repository.NewPostRepository(s.DB)
	postService := service.NewPostService(postRepo)
	postHandler := handler.NewPostHandler(postService)

	s.Router.POST("/makePost", postHandler.MakePost)
	s.Router.GET("/getPostList", postHandler.GetPostList)
}
