package model

type Like struct {
	// Harus huruf besar depannya untuk generate tabel di database
	Id      int `json:"id" gorm:"type:int;PRIMARY KEY;AUTO_INCREMENT;NOT NULL"`
	User_id int `json:"user_id" gorm:"int;NOT NULL"`
	Post_id int `json:"post_id" gorm:"int;NOT NULL"`
}

func (l *Like) TableName() string {
	return "like"
}