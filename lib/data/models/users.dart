import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';

class UserModel extends FirestoreModel<UserModel> {
  String email;
  String numPhone;
  String displayName;
  String userName;
  String password;
  String cityName;
  String areaName;
  String streetName;

  UserModel({
    this.displayName,
    this.email,
    this.numPhone,
    this.password,
    this.userName,
    this.areaName,
    this.cityName,
    this.streetName,
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
        'cityName': cityName,
        'areaName': areaName,
        'streetName': streetName,
      };

  UserModel.fromMap(Map<String, dynamic> map) {
    this.numPhone = map['numPhone'] ?? '';
    this.displayName = map['displayName'] ?? '';
    this.userName = map['userName'] ?? '';
    this.email = map['email'] ?? '';
    this.streetName = map['streetName'];
    this.cityName = map['cityName'];
    this.areaName = map['areaName'];
  }

  @override
  ResponseBuilder<UserModel> get responseBuilder =>
      (map) => UserModel.fromMap(map);

  @override
  String get collectionName => 'users';
}
