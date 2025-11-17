import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _usersRef => _firestore.collection('users');

  Future<void> addUser(UserModel user) async {
    await _usersRef.doc(user.uid).set(user.toJson());
  }

  Future<UserModel> getUser(String uid) async {
    final doc = await _usersRef.doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("User not found");
    }

    final data = doc.data() as Map<String, dynamic>;
    data['uid'] = doc.id;

    return UserModel.fromJson(data);
  }

  Future<void> updateProfileImage(String uid, String imgURL) async {
    await _usersRef.doc(uid).update({'imgURL': imgURL});
  }

  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.uid).update({
      'name': user.name,
      'email': user.email,
      if (user.imgURL != null) 'imgURL': user.imgURL,
    });
  }

  Future<void> deleteUser(String uid) async {
    final userDocRef = _usersRef.doc(uid);

    final todosSnapshot = await userDocRef.collection('todos').get();

    for (final doc in todosSnapshot.docs) {
      await doc.reference.delete();
    }

    await userDocRef.delete();
  }
}
