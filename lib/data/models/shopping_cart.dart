import 'package:firestore_model/firestore_model.dart';
import 'package:salla_app/data/models/product.dart';

class ShoppingCart extends SubCollectionModel<ShoppingCart> {
  Product product;
  ShoppingCart({this.product});
  ShoppingCart.fromMap(Map<String, dynamic> map) {
    this.product = map['product'];
  }
  @override
  ResponseBuilder<ShoppingCart> get responseBuilder =>
      (map) => ShoppingCart.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'product': this.product,
      };
}
