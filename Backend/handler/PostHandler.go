package handler

import (
	"Project/Aesos/request"
	"Project/Aesos/service"
	"net/http"
	"strconv"

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

	user_id, err := strconv.Atoi(c.Query("user_id"))

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message" : err.Error(),
		})
		return
	}

	post, status, err := h.Service.GetPostList(user_id)

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