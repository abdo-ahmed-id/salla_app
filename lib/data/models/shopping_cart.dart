import 'package:firestore_model/firestore_model.dart';

class ShoppingCart extends SubCollectionModel<ShoppingCart> {
  String category;
  String title;
  String price;
  num rate;
  String description;
  String imageScr;
  num amount = 1;
  num totalCoast;
  String company;
  String subTitle;
  ShoppingCart(
      {this.category,
      this.title,
      this.price,
      this.rate,
      this.description,
      this.imageScr,
      this.amount,
      this.totalCoast,
      this.subTitle,
      this.company});

  ShoppingCart.fromMap(Map<String, dynamic> map) {
    this.category = map['category'];
    this.title = map['title'];
    this.description = map['description'];
    this.imageScr = map['imageScr'];
    this.price = map['price'];
    this.rate = map['rate'];
    this.amount = map['amount'];
    this.totalCoast = map['totalCoast'];
    this.subTitle = map['subTitle'];
    this.company = map['company'];
  }
  @override
  ResponseBuilder<ShoppingCart> get responseBuilder =>
      (map) => ShoppingCart.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'category': this.category,
        'title': this.title,
        'description': this.description,
        'imageScr': this.imageScr,
        'price': this.price,
        'rate': this.rate,
        'amount': this.amount ?? 1,
        'totalCoast': this.totalCoast,
        'subTitle': this.subTitle,
        'company': this.company,
      };
}
