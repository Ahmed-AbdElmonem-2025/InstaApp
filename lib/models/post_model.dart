

class PostModel {
  String? profileImg;
  String? username;
  String? description;
  String? imgPost;
  String? uid;
  String? postId ;
  String? datePuplished ;
  List?  likes ;
  PostModel({
    required this.profileImg,
    required this.username,
    required this.description,
    required this.imgPost,
    required this.uid,
    required this.postId,
    required this.datePuplished,
     required this.likes,  
  });

  PostModel.fromJson({required Map<String, dynamic> data}) {
    profileImg = data['profileImg'];
    username = data['username'];
    description = data['description'];
    imgPost = data['imgPost'];
    uid = data['uid'];
    postId = data['postId'];
    datePuplished = data['datePuplished']  ;
    likes = data['likes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImg': profileImg,
      'username': username,
      'description': description,
      'imgPost': imgPost,
      'uid':uid,
      'postId': postId,
       'datePuplished': datePuplished,
       'likes': likes,
    };
  }
}
