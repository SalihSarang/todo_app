class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String? imgURL;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    this.imgURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      imgURL: json['imgURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      if (imgURL != null) 'imgURL': imgURL,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? imgURL,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imgURL: imgURL ?? this.imgURL,
    );
  }
}
