import 'package:firestore_model/firestore_model.dart';

class Product extends FirestoreModel<Product> {
  String category;
  String title;
  String price;
  num rate;
  num discountP;
  String description;
  List<String> images;
  List<String> favList = [];
  List<String> shoppingCartList = [];
  String company;
  String subTitle;
  String brandCar;
  String modelCar;

  Product(
      {this.category,
      this.title,
      this.price,
      this.rate,
      this.description,
      this.images,
      this.company});

  Product.fromMap(Map<String, dynamic> map) {
    this.category = map['category'];
    this.favList = map['favList'] is List ? map['favList'].cast<String>() : [];
    this.shoppingCartList = map['shoppingCartList'] is List
        ? map['shoppingCartList'].cast<String>()
        : [];
    this.images = map['images'] is List ? map['images'].cast<String>() : null;
    this.title = map['title'];
    this.description = map['description'];
    this.discountP = map['discountP'];

    this.price = map['price'];
    this.rate = map['rate'];
    this.company = map['company'];
    this.subTitle = map['subTitle'];
    this.brandCar = map['brandCar'];
    this.modelCar = map['modelCar'];
  }
  @override
  ResponseBuilder<Product> get responseBuilder => (map) => Product.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'category': this.category,
        'title': this.title,
        'description': this.description,
        'images': this.images,
        'price': this.price,
        'rate': this.rate,
        'favList': this.favList,
        'shoppingCartList': this.shoppingCartList,
        'subTitle': this.subTitle,
        'company': this.company,
        'brandCar': this.brandCar,
        'modelCar': this.modelCar,
      };
}
