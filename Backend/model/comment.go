package model

import "time"

type Comment struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id            int    `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	User_id       int `json:"user_id" gorm:"int;NOT NULL"`
	Post_id         int `json:"post_id" gorm:"int;NOT NULL"`
	Comment      string `json:"comment" gorm:"type:varchar(300);NOT NULL"`
	Created_at    time.Time `json:"created_at" gorm:"default:CURRENT_TIMESTAMP"`
}

func (C *Comment) TableName() string {
	return "comment"
}