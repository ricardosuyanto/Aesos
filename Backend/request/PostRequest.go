package request

type PostRequest struct {
	UserID      int    `json:"user_id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Picture     string `json:"picture"`
}