package handler

import (
	"Project/Aesos/request"
	"Project/Aesos/service"
	"net/http"

	"github.com/gin-gonic/gin"
)

type PostHandler struct {
	Service service.PostService
}

func NewPostHandler(service service.PostService) *PostHandler {
	return &PostHandler{service}
}

func (h *PostHandler) MakePost(c *gin.Context) {
	var request request.PostRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message" :"Invalid request Body",
		})
		return
	}

	status, err := h.Service.MakePost(request) 

	if err != nil {
		c.JSON(status, gin.H{
			"message" :err.Error(),
		})
		return
	}

	c.JSON(status, gin.H{
		"message" : "Success making new post!",
	})
}

func (h *PostHandler) GetPostList(c *gin.Context) {

	post, status, err := h.Service.GetPostList()

	if err != nil {
		c.JSON(status, gin.H{
			"message" : err.Error(),
		})
		return
	}

	c.JSON(status, gin.H{
		"message": "Success retrieving post!",
		"post":post,
	})
}