import 'package:cloud_firestore/cloud_firestore.dart';

class MessageToModel{

  String? name;
  String? dataname;
  String? time;
  String? to;
  String? addby;
  String? nameday;
  Timestamp? timestamp;
  Map<String, dynamic>? map1;


  MessageToModel({
     this.timestamp,
    this.name,
    this.to,
    this.dataname,
    this.time,
    this.addby,
    this.nameday,
    this.map1,
   });
  MessageToModel.fromJson(Map<String,dynamic>json)
  {
     timestamp=json['timestamp'];
     dataname=json['dataname'];
     to=json['to'];
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
        'to':to,
        'time':time,
        'timestamp':timestamp,
        'map1':map1,
        };

  }
}