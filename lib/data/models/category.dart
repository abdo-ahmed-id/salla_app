import 'package:firestore_model/firestore_model.dart';

class Category extends FirestoreModel<Category> {
  String title;
  String imageScr;

  Category({this.title, this.imageScr});
  Category.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.imageScr = map['imageScr'];
  }
  @override
  ResponseBuilder<Category> get responseBuilder =>
      (map) => Category.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'title': this.title,
        'imageScr': this.imageScr,
      };
}
