import 'package:firestore_model/firestore_model.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';

class Order extends FirestoreModel<Order> {
  num orderNum;
  num productsNum;
  UserModel user;
  List<ShoppingCart> products;

  Order({this.user, this.products, this.orderNum});
  Order.fromMap(Map<String, dynamic> map) {
    this.orderNum = map['orderNum'];
    this.user =
        map['user'] is Map ? UserModel.fromMap(map['user']) : UserModel();
    this.products = new List();
    if (map['products'] is List) {}
    map['products'];
  }
  @override
  ResponseBuilder<Order> get responseBuilder => (map) => Order.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'user': user.toMap,
        'products': products.map((e) => e.toMap),
        'orderNum': orderNum,
      };
}
