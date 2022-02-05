import 'package:firestore_model/firestore_model.dart';

class Category extends FirestoreModel<Category> {
  String title;
  String imageScr;
  String brandCar;
  String categoryCar;
  String modelCar;
  bool carInformation;

  Category({this.title, this.imageScr});
  Category.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.imageScr = map['imageScr'];
    this.brandCar = map['brandCar'];
    this.categoryCar = map['categoryCar'];
    this.modelCar = map['modelCar'];
    this.carInformation = map['carInformation'];
  }
  @override
  ResponseBuilder<Category> get responseBuilder =>
      (map) => Category.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'title': this.title,
        'imageScr': this.imageScr,
        'brandCar': this.brandCar,
        'categoryCar': this.categoryCar,
        'modelCar': this.modelCar,
        'carInformation': this.carInformation,
      };
}
