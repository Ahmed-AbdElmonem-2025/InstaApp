class UserModel {
  String? name;
  String? email;
  String? image;
   String? title;
  String? id;
  List? follwers ;
   List ?  follwing ;
  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.image,
    required this.title,
     required this.follwers,
     required this.follwing,
  });

  UserModel.fromJson({required Map<String, dynamic> data}) {
    name = data['name'];
    email = data['email'];
    image = data['imageUrl'];
    id = data['userId'];
    title = data['title'];
    follwers = data['follwers'];
    follwing = data['follwing'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'imageUrl': image,
      'userId': id,
      'title': title,
      'follwers': [],
      'follwing': [],
    };
  }
}
