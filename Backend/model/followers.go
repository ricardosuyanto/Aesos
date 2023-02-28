package model

import "time"

type Followers struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id          int       `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	User_id     int       `json:"user_id" gorm:"int;NOT NULL"`
	Follower_id int       `json:"follower_id" gorm:"int;NOT NULL"`
	Created_at  time.Time `json:"created_at" gorm:"default:CURRENT_TIMESTAMP"`
}

func (f *Followers) TableName() string {
	return "followers"
}