import 'package:firestore_model/firestore_model.dart';

class Order extends FirestoreModel {
  String userName;
  String phoneNum;
  String streetName;
  String cityName;
  String areaName;
  num totalPrice;
  num amount;
  Order(
      {this.userName,
      this.phoneNum,
      this.streetName,
      this.cityName,
      this.areaName,
      this.totalPrice,
      this.amount});
  Order.fromMap(Map<String, dynamic> map) {
    this.userName = map['userName'];
    this.phoneNum = map['phoneNum'];
    this.streetName = map['streetName'];
    this.cityName = map['cityName'];
    this.areaName = map['areaName'];
    this.totalPrice = map['totalPrice'];
    this.amount = map['amount'];
  }
  @override
  ResponseBuilder<Model> get responseBuilder => (map) => Order.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'userName': this.userName,
        'phoneNum': this.phoneNum,
        'streetName': this.streetName,
        'cityName': this.cityName,
        'areaName': this.areaName,
        'totalPrice': this.totalPrice,
        'amount': this.amount,
      };
}
