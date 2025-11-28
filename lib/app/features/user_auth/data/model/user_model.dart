class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? imgURL;
  final String? address;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.imgURL,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imgURL: json['imgURL'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      if (imgURL != null) 'imgURL': imgURL,
      if (address != null) 'address': address,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imgURL,
    String? address,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      imgURL: imgURL ?? this.imgURL,
      address: address ?? this.address,
    );
  }
}
