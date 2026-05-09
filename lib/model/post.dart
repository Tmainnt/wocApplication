class Post {
  final int _postId;
  final int _userId;
  String _content;
  String _image;
  final DateTime _createTimestamp;
  DateTime _updteTimestamp;

  Post({
    required int postId,
    required int userId,
    required String content,
    required String image,
    required DateTime cts,
    required DateTime uts,
  }) : _postId = postId,
       _userId = userId,
       _content = content,
       _image = image,
       _createTimestamp = cts,
       _updteTimestamp = uts;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["post_id"],
      userId: json["user_id"],
      content: json["post_content"],
      image: json["post_image"],
      cts: json["create_timestamp"],
      uts: json["update_timestamp"],
    );
  }

  int get postID => _postId;
  int get userID => _userId;
  String get content => _content;
  String get image => _image;
  DateTime get createTimestamp => _createTimestamp;
  DateTime get updateTimestatmp => _updteTimestamp;
}
