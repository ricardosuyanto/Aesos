package model

import "time"

type Notification struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id            int    `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	User_id       int `json:"user_id" gorm:"int;NOT NULL"`
	Title         string `json:"title" gorm:"type:varchar(50);NOT NULL"`
	Message   string `json:"message" gorm:"type:varchar(200);NOT NULL"`
	Created_at    time.Time `json:"created_at" gorm:"default:CURRENT_TIMESTAMP"`
	Read_at    time.Time `json:"updated_at" gorm:"type:timestamp"`
}

func (n *Notification) TableName() string {
	return "notification"
}