import 'package:firestore_model/firestore_model.dart';

class PromoCode extends FirestoreModel<PromoCode> {
  String title;
  String code;
  num discountP;
  PromoCode({
    this.title,
    this.code,
    this.discountP,
  });
  PromoCode.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.code = map['code'];
    this.discountP = map['discountP'];
  }

  @override
  ResponseBuilder<PromoCode> get responseBuilder =>
      (map) => PromoCode.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'title': this.title,
        'code': this.code,
        'discountP': this.discountP,
      };
  @override
  String get collectionName => 'promoCodes';
}
