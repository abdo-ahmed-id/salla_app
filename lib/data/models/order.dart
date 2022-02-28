import 'package:firestore_model/firestore_model.dart';
import 'package:salla_app/data/models/promocode.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';

class Order extends FirestoreModel<Order> {
  num orderCoast;
  num productsNum;
  String notes;
  UserModel user;
  PromoCode promoCode;
  List<ShoppingCart> products;

  Order(
      {this.user, this.products, this.notes, this.orderCoast, this.promoCode});
  Order.fromMap(Map<String, dynamic> map) {
    orderCoast = map['orderCoast'];
    notes = map['notes'];
    user = map['user'] is Map ? UserModel.fromMap(map['user']) : UserModel();
    promoCode = map['promoCode'] is Map
        ? PromoCode.fromMap(map['promoCode'])
        : PromoCode();
    products = <ShoppingCart>[];
    if (map['products'] is List) {
      map['products'].forEach((item) {
        products.add(ShoppingCart.fromMap(item));
      });
    }
  }
  @override
  ResponseBuilder<Order> get responseBuilder => (map) => Order.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'user': user.toMap,
        'promoCode': promoCode?.toMap,
        'products': products.map((e) => e.toMap).toList(),
        'orderCoast': orderCoast,
        'notes': notes,
      };
}
