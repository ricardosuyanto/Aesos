package model

import "time"

type Post struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id            int    `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	User_id       int `json:"user_id" gorm:"int;NOT NULL"`
	Title         string `json:"title" gorm:"type:varchar(50);NOT NULL"`
	Description   string `json:"description" gorm:"type:varchar(200);NOT NULL"`
	Picture       []byte `json:"picture" gorm:"type:bytea"`
	EncodedPicture string `json:"encoded_picture" gorm:"-"`
	Created_at    time.Time `json:"created_at" gorm:"default:CURRENT_TIMESTAMP"`
	Comment       []Comment `gorm:"foreignkey:post_id"`
	Like          []Like `gorm:"foreignkey:post_id"`
}

func (p *Post) TableName() string {
	return "post"
}