
import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftsDataModel{

  String? car_Type;
  int? no_start;
  String? start_path;
  int? no_end;
  String? end_path;
  String? notes;
  String? day_data;
  Timestamp? timestamp;
   int? total_time;
  List<dynamic>? app_income;
  List<dynamic>? out_income;
  List<dynamic>? exp_petrol;
  List<dynamic>? exp_gas;
  List<dynamic>? app_charge;
  List<dynamic>? more_outcome;
  List<dynamic>? supplies;
  String? uId;
    ShiftsDataModel({
    this.start_path,
    this.no_start,
    this.end_path,
    this.no_end,
   this.car_Type,
   this.app_income,
   this.out_income,
   this.exp_petrol,
   this.exp_gas,
   this.app_charge,
   this.more_outcome,
   this.timestamp,
   this.supplies,
   this.notes,
   this.day_data,
   this.uId,
   this.total_time,
  });
 ShiftsDataModel.fromJson(Map<String,dynamic>json)
 {
   start_path=json['start_path'];
   no_start=json['no_start'];
   end_path=json['end_path'];
   day_data=json['day_data'];
   no_end=json['no_end'];
   car_Type=json['car_Type'];
   app_income=json['app_income'];
   out_income=json['out_income'];
   exp_gas=json['exp_gas'];
   exp_petrol=json['exp_petrol'];
   timestamp=json['timestamp'];
   app_charge=json['app_charge'];
   more_outcome=json['more_outcome'];
   supplies=json['supplies'];
   notes=json['notes'];
   uId=json['uId'];
   total_time=json['total_time'];
    }
 Map<String,dynamic>toMap(){
   return
       {
         'car_Type':car_Type,
         'no_start':no_start,
         'start_path':start_path,
         'timestamp':timestamp,
         'no_end':no_end,
         'end_path':end_path,
         'app_income':app_income,
         'out_income':out_income,
         'exp_petrol':exp_petrol,
         'day_data':day_data,
         'app_charge':app_charge,
         'more_outcome':more_outcome,
         'supplies':supplies,
         'notes':notes,
         'uId':uId,
         'total_time':total_time,
         };

 }
}