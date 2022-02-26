import 'package:firestore_model/firestore_model.dart';

class Favoriets extends SubCollectionModel<Favoriets> {
  String category;
  String title;
  String price;
  num rate;
  num discountP;
  String description;
  List<String> images;
  String company;
  String subTitle;
  Favoriets(
      {this.category,
      this.title,
      this.price,
      this.rate,
      this.description,
      this.images,
      this.subTitle,
      this.company});

  Favoriets.fromMap(Map<String, dynamic> map) {
    this.category = map['category'];
    this.title = map['title'];
    this.discountP = map['discountP'];
    this.description = map['description'];
    this.images = map['images'] is List ? map['images'].cast<String>() : null;
    this.price = map['price'];
    this.rate = map['rate'];
    this.subTitle = map['subTitle'];
    this.company = map['company'];
  }
  @override
  ResponseBuilder<Favoriets> get responseBuilder =>
      (map) => Favoriets.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'category': this.category,
        'title': this.title,
        'description': this.description,
        'images': this.images,
        'price': this.price,
        'rate': this.rate,
        'discountP': this.discountP,
        'subTitle': this.subTitle,
        'company': this.company,
      };
}
