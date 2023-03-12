package repository

import (
	"Project/Aesos/model"

	"gorm.io/gorm"
)

type PostRepository interface {
	MakePost(post model.Post) (error) 
	GetPostList(user_id int) ([]model.Post, error)
}

type postRepository struct {
	db *gorm.DB
}

func NewPostRepository(db *gorm.DB) *postRepository {
	return &postRepository{db}
}

func (r *postRepository) MakePost(post model.Post) (error) {
	
	result := r.db.Create(&post)

	if result.Error != nil {
		return result.Error
	}

	return nil
}

func (r *postRepository) GetPostList(user_id int) ([]model.Post, error) {
	var posts []model.Post

	//var user model.User

	// var followers []model.Followers

	// r.db.Where("user_id = ?", 1).Find(&followers)

	// var followerIDs []int 

	// for _, f := range followers {
	// 	followerIDs = append(followerIDs, f.Follower_id)
	// }

	//getAllPost := r.db.Where("user_id In (?)", followerIDs).Find(&posts)

	//getAllPost :=r.db.Debug().Preload("User").Table("post").Joins("JOIN user ON user.id = post.user_id").Joins("LEFT JOIN followers ON followers.follower_id = user.id").Joins("LEFT JOIN following ON following.following_id = user.id").Where("user.id = ? OR followers.user_id = ? OR following.user_id = ?", 1, 1, 1).Find(&posts)

	//getAllPost := r.db.Preload("Post").Find(&user)

	// Ambil semua posts yang di post user
	if err := r.db.Where("user_id = ?", user_id).Find(&posts).Error; err != nil {
        return nil, err
    }

    // Ambil semua ID yang user follow
    var followingIDs []uint
    if err := r.db.Table("following").Select("following_id").Where("user_id = ?", user_id).Pluck("following_id", &followingIDs).Error; err != nil {
        return nil, err
    }

    // Ambile semua ID yang follower user
    var followerIDs []uint
    if err := r.db.Table("followers").Select("follower_id").Where("user_id = ?", user_id).Pluck("follower_id", &followerIDs).Error; err != nil {
        return nil, err
    }

    // Ambil post nya
    if err := r.db.Where("user_id IN (?)", followingIDs).Or("user_id IN (?)", followerIDs).Find(&posts).Error; err != nil {
        return nil, err
    }

	// if getAllPost.Error != nil {
	// 	return nil, getAllPost.Error
	// }

	posts = append([]model.Post{}, posts...)

	return posts, nil
}