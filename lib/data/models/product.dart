import 'package:firestore_model/firestore_model.dart';

class Product extends FirestoreModel<Product> {
  String category;
  String title;
  String price;
  num rate;
  String description;
  String imageScr;
  List<String> favList = [];
  String company;
  String subTitle;
  String brandCar;
  String categoryCar;
  String modelCar;

  Product({
    this.category,
    this.title,
    this.price,
    this.rate,
    this.description,
    this.imageScr,
  });

  Product.fromMap(Map<String, dynamic> map) {
    this.category = map['category'];
    this.favList = map['favList'] is List ? map['favList'].cast<String>() : [];
    this.title = map['title'];
    this.description = map['description'];
    this.imageScr = map['imageScr'];
    this.price = map['price'];
    this.rate = map['rate'];
    this.company = map['company'];
    this.subTitle = map['subTitle'];
    this.brandCar = map['brandCar'];
    this.categoryCar = map['categoryCar'];
    this.modelCar = map['modelCar'];
  }
  @override
  ResponseBuilder<Product> get responseBuilder => (map) => Product.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'category': this.category,
        'title': this.title,
        'description': this.description,
        'imageScr': this.imageScr,
        'price': this.price,
        'rate': this.rate,
        'favList': this.favList,
        'subTitle': this.subTitle,
        'company': this.company,
        'brandCar': this.brandCar,
        'categoryCar': this.categoryCar,
        'modelCar': this.modelCar,
      };
}
