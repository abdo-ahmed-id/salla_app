import 'package:firestore_model/firestore_model.dart';

class Order extends FirestoreModel {
  String userName;
  String phoneNum;
  String streetName;
  String cityName;
  String areaName;
  @override
  ResponseBuilder<Model> get responseBuilder => throw UnimplementedError();

  @override
  Map<String, dynamic> get toMap => throw UnimplementedError();
}
