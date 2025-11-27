class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? imgURL;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.imgURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imgURL: json['imgURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      if (imgURL != null) 'imgURL': imgURL,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imgURL,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      imgURL: imgURL ?? this.imgURL,
    );
  }
}
