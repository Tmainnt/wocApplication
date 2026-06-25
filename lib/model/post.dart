class Post {
  final int _postId;
  final int _userId;
  String _content;
  String _image;
  final DateTime _createTimestamp;
  DateTime _updteTimestamp;
  String _postVisibility;
  String _postStatus;
  int _likeCount;
  int _commentCount;

  Post({
    required int postId,
    required int userId,
    required String content,
    required String image,
    required DateTime cts,
    required DateTime uts,
    required String postV,
    required String postS,
    required int likeCount,
    required int commentCount,
  }) : _postId = postId,
       _userId = userId,
       _content = content,
       _image = image,
       _createTimestamp = cts,
       _updteTimestamp = uts,
       _postVisibility = postV,
       _postStatus = postS,
       _likeCount = likeCount,
       _commentCount = commentCount;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["post_id"],
      userId: json["user_id"],
      content: json["post_content"],
      image: json["post_image"],
      cts: json["create_timestamp"],
      uts: json["update_timestamp"],
      postV: json["post_visibility"],
      postS: json["post_status"],
      likeCount: json["like_count"],
      commentCount: json["comment_count"],
    );
  }

  int get postID => _postId;
  int get userID => _userId;
  String get content => _content;
  String get image => _image;
  DateTime get createTimestamp => _createTimestamp;
  DateTime get updateTimestatmp => _updteTimestamp;
  String get postVisiblity => _postVisibility;
  String get postStatus => _postStatus;
  int get likeCount => _likeCount;
  int get commentCount => _commentCount;
}
