import 'package:firestore_model/firestore_model.dart';

class Favoriets extends SubCollectionModel<Favoriets> {
  String category;
  String title;
  String price;
  num rate;
  String description;
  String imageScr;
  String company;
  String subTitle;
  Favoriets(
      {this.category,
      this.title,
      this.price,
      this.rate,
      this.description,
      this.imageScr,
      this.subTitle,
      this.company});

  Favoriets.fromMap(Map<String, dynamic> map) {
    this.category = map['category'];
    this.title = map['title'];
    this.description = map['description'];
    this.imageScr = map['imageScr'];
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
        'imageScr': this.imageScr,
        'price': this.price,
        'rate': this.rate,
        'subTitle': this.subTitle,
        'company': this.company,
      };
}
