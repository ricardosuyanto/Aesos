package api

import (
	"os"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type server struct {
	Router *gin.Engine
	DB *gorm.DB
}

func MakeServer(db *gorm.DB) *server {
	s := &server{
		Router: gin.Default(),
		DB: db,
	}

	return s
}

func (s *server) RunServer() {
	s.SetUpRouter()
	port := os.Getenv("PORT")
	if err := s.Router.Run(":" + port); err != nil {
		panic(err)
	}
}