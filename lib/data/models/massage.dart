import 'package:firestore_model/firestore_model.dart';

class Massage extends SubCollectionModel<Massage> {
  String text;
  String receiverId;
  String senderId;
  Massage({this.text, this.receiverId, this.senderId});
  Massage.fromMap(Map<String, dynamic> map) {
    this.text = map['text'];
    this.receiverId = map['receiverId'];
    this.senderId = map['senderId'];
  }
  @override
  ResponseBuilder<Massage> get responseBuilder => (map) => Massage.fromMap(map);

  @override
  Map<String, dynamic> get toMap => {
        'text': this.text,
        'receiverId': this.receiverId,
        'senderId': this.senderId,
      };
}
