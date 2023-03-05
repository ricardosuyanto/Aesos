package model

import "time"

type User struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id            int    `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	Username      string `json:"username" gorm:"type:varchar(20);NOT NULL;unique"`
	Password      []byte `json:"password" gorm:"type:bytea;NOT NULL"`
	Email         string `json:"email" gorm:"type:varchar(50);NOT NULL"`
	Date_of_birth time.Time `json:"date_of_birth" gorm:"type:date"`
	Bio 		  string `json:"bio" gorm:"type:varchar(200)"`
	Profile_pic   string `json:"profile_pic" gorm:"type:text"`
	Gender        string `json:"gender" gorm:"type:varchar(10)"`
	Created_at    time.Time `json:"created_at" gorm:"default:CURRENT_TIMESTAMP"`
	Updated_at    time.Time `json:"updated_at" gorm:"type:timestamp"`
	Post          []Post   `gorm:"foreignkey:user_id"`
	Comment       []Comment `gorm:"foreignkey:user_id"`
	Like          []Like `gorm:"foreignkey:user_id"`
	Notification  []Notification `gorm:"foreignkey:user_id"`
	Following     []Following `gorm:"foreignkey:following_id"`
	UserFollowing []Following `gorm:"foreignkey:user_id"`
	Followers     []Followers `gorm:"foreignkey:follower_id"`
	UserFollowers     []Followers `gorm:"foreignkey:user_id"`
}

func (u *User) TableName() string {
	return "user"
}