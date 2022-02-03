import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';

class UserModel extends FirestoreModel<UserModel> {
  String email;
  String numPhone;
  String displayName;
  String userName;
  String password;

  UserModel({
    this.displayName,
    this.email,
    this.numPhone,
    this.password,
  });

  UserModel.fromAuth(User userAuth) {
    this.email = userAuth.email ?? '';
    this.numPhone = userAuth.phoneNumber ?? '';
    this.displayName = userAuth.displayName ?? '';

    this.userName = userAuth.email.split('@').first.trim() ?? '';
  }

  @override
  Map<String, dynamic> get toMap => {
        "displayName": displayName,
        "userName": email.split('@').first.trim() ?? '',
        'email': email,
        "numPhone": numPhone,
      };

  UserModel.fromMap(Map<String, dynamic> map) {
    this.numPhone = map['numPhone'] ?? '';
    this.displayName = map['displayName'] ?? '';
    this.userName = map['userName'] ?? '';
    this.email = map['email'] ?? '';
  }

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (map) => UserModel.fromMap(map);

  @override
  String get collectionName => 'users';
}
