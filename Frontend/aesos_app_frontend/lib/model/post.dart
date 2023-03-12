class Post {
  final String title;
  final String description;
  final String picture;
  final int user_id;

  Post({
    required this.title,
    required this.description,
    required this.picture,
    required this.user_id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      description: json['description'],
      title: json['title'],
      picture: json['picture'],
      user_id: json['user_id']
    );
  }
}