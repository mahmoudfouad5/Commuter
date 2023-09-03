import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel{

  String? name;
  String? nameday;
  Timestamp? timestamp;

   MessagesModel({
     this.timestamp,
    this.name,
    this.nameday,
   });
  MessagesModel.fromJson(Map<String,dynamic>json)
  {
     timestamp=json['timestamp'];
    name=json['name'];
     nameday=json['nameday'];
   }
  Map<String,dynamic>toMap(){
    return
      {
        'name':name,
        'nameday':nameday,
        'timestamp':timestamp,
        };

  }
}