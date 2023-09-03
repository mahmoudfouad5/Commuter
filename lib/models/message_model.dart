import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{

  String? name;
  String? dataname;
  String? time;
  String? addby;
  String? nameday;
  Timestamp? timestamp;
  Map<String, dynamic>? map1;


  MessageModel({
     this.timestamp,
    this.name,
    this.dataname,
    this.time,
    this.addby,
    this.nameday,
    this.map1,
   });
  MessageModel.fromJson(Map<String,dynamic>json)
  {
     timestamp=json['timestamp'];
     dataname=json['dataname'];
    name=json['name'];
     time=json['time'];
     addby=json['addby'];
     nameday=json['nameday'];
     map1=json['map1'];
   }
  Map<String,dynamic>toMap(){
    return
      {
        'name':name,
        'dataname':dataname,
        'nameday':nameday,
        'addby':addby,
        'time':time,
        'timestamp':timestamp,
        'map1':map1,
        };

  }
}