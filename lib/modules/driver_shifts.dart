import 'dart:io';
import 'dart:ui' as ui;


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/componant/constant.dart';
import 'package:logo/shared/cubit/cubit.dart';
import 'package:logo/shared/cubit/states.dart';
import 'package:logo/shared/network/local/cache_helper.dart';
import 'package:intl/intl.dart';

import 'timer_screen.dart';

class DriverShifts extends StatefulWidget {
  DriverShifts({Key? key}) : super(key: key);

  @override
  State<DriverShifts> createState() => _DriverShiftsState();
}

class _DriverShiftsState extends State<DriverShifts> {
  final GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  List<Widget> rows = [];
  List<Widget> rows1 = [];
  List<Widget> rows2 = [];
  List<Widget> rows3 = [];
  List<Widget> rows4 = [];
  List<Widget> rows5 = [];
  List<Widget> rows6 = [];
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllers1 = [];
  List<TextEditingController> controllers2 = [];
  List<TextEditingController> controllers3 = [];
  List<TextEditingController> controllers4 = [];
  List<TextEditingController> controllers5= [];
  List<TextEditingController> controllers6= [];
  List<File> image =[];
  List<File> image2 =[];
  List<File> image3 =[];
  List<File> image4 =[];
  List<File> image5 =[];
  List<String> imageUrls =[];
  List<String> imageUrls1 =[];
  List<String> imageUrls2 =[];
  List<String> imageUrls3 =[];
  List<String> imageUrls4 =[];
  String imageUrl ='';
  String imageUrl1 ='';
  List<bool> isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  String? _chosenValue;
  String dropdownValue = 'One';
  int cdx = 0 ;
  File? imagee = null;

  File? imagee1 = null;

  final imagepicker = ImagePicker();

  var readController = TextEditingController(text: CacheHelper.getData(key: "nostar", ));
  var readController1 = TextEditingController();


  List<bool> isincome = [
    false,
    false,
  ];
  List<String> isincomeName = [
    "إيراد التطبيقات",
    "رحلات خارجية",
  ];
  List<bool> isout  = [
    false,
  ];


  List<bool> isoutcome = [
    false,
    false,
    false,
    false,
  ];
  List<String> isoutcomeName = [
    "البنزين",
    "الغاز",
    "شحن التطبيقات",
    "مصروفات اضافية",
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 2; i++) {
      controllers.add(TextEditingController());
      controllers1.add(TextEditingController());
      controllers2.add(TextEditingController());
      controllers3.add(TextEditingController());
      controllers4.add(TextEditingController());
      controllers5.add(TextEditingController());
    }

    getListOfStrings();
    CacheHelper.getData(key: "istar", ) ;
    CacheHelper.getData(key: "nostar", ) ;
  }


  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    var dateFormatter = DateFormat('yyyy-MM-dd');
    var timeFormatter = DateFormat('hh:mm a');
    var formattedDate = dateFormatter.format(now);



    var cubit = Appcubit.get(context);

    return BlocProvider(
      create: (context) => Appcubit.get(context),
      child: BlocConsumer<Appcubit, AppStates>(
        builder: (context, state) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            toolbarHeight: 42.h,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "commuter",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: "Harlow",
              ),
            ),
          ),
          backgroundColor: HexColor("#FBFBFB"),
          body: Container(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Image.asset(
                                "assets/images/Rectangle 32.png",
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 140.h,
                              ),
                              buildCoverItem(context),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      buildUserItem(
                        context, cubit.titel[0], cubit.iconPath[0], 0,
                      ),
                      Visibility(child:  drobList0(  ),visible: isOpen[0],),
                      buildUserItem(
                        context, cubit.titel[1], cubit.iconPath[1], 1,
                      ),
                      Visibility(child:  Column(
                        children: [
                          drobList1(path:cubit.titel[1]  , path2:formattedDate,  ),


                        ],
                      ),visible: isOpen[1],),

                      buildUserItem(
                        context, cubit.titel[2], cubit.iconPath[2], 2,
                      ),
                      Visibility(
                          visible: isOpen[2],
                          child:
                          Column(
                            children: [
                              addItem(
                                  name: isincomeName,index: 0,isexpand:isincome ,image: image,controllers:controllers,rows: rows,path:isincomeName[0] ,
                                  imageUrls:imageUrls
                                  ,path2:formattedDate  ),
                              buildappIncome(isexpand:isincome ,index:0,image: image,controllers:controllers,rows: rows  ),

                              addItem1(name: isincomeName,index: 1,isexpand:isincome  ,controllers:controllers1,rows: rows1),
                              buildoutputTrips(index: 1,isexpand:isincome  ,controllers:controllers1,rows: rows1),

                            ],
                          )),
                      buildUserItem(
                        context, cubit.titel[3], cubit.iconPath[3], 3,
                      ),
                      Visibility(
                          visible: isOpen[3],
                          child: Column(
                            children: [
                              addItem2(name: isoutcomeName,  imageUrls:imageUrls1,
                                  index: 0,isexpand:isoutcome ,controllers:controllers2,rows: rows2,image:image2 ,path:isoutcomeName[0] ,path2:formattedDate ),
                              buildappOutcome1(isexpand:isoutcome ,index:0   ,controllers:controllers2,rows: rows2,image:image2 ),

                              addItem2(name: isoutcomeName,imageUrls:imageUrls2,index: 1,isexpand:isoutcome ,image: image3,controllers:controllers3,rows: rows3  ,path:isoutcomeName[1] ,path2:formattedDate),
                              buildappOutcome1(isexpand:isoutcome ,index:1  ,image: image3,controllers:controllers3,rows: rows3),

                              addItem2(name: isoutcomeName,index: 2,imageUrls:imageUrls3,isexpand:isoutcome ,image: image4,controllers:controllers4,rows: rows4 ,path:isoutcomeName[2] ,path2:formattedDate ),
                              buildappOutcome1(isexpand:isoutcome ,index:2 ,image: image4,controllers:controllers4,rows: rows4),

                              addItem2(name: isoutcomeName,index: 3,imageUrls:imageUrls4 ,isexpand:isoutcome ,image: image5,controllers:controllers5,rows: rows5 ,path:isoutcomeName[3] ,path2:formattedDate ),
                              buildappOutcome1(isexpand:isoutcome ,index:3  ,image: image5,controllers:controllers5,rows: rows5),


                            ],
                          )),

                      buildUserItem(
                        context, cubit.titel[4], cubit.iconPath[4], 4,
                      ),
                      Visibility(
                          visible: isOpen[4],
                          child: Column(
                            children: [
                              addItem3(index: 0, isexpand:isout , name: "التوريد ", rows: rows6, controllers: controllers6,  ),
                              buildout(index: 0, isexpand: isout,rows: rows6, controllers: controllers6,),
                            ],
                          )),
                      buildUserItem(
                        context, cubit.titel[5], cubit.iconPath[5], 5,
                      ),
                      Visibility(child:  drobList2(path:cubit.titel[5] , path2:formattedDate,   ),visible: isOpen[5],),


                      buildUserItem(
                        context, cubit.titel[6], cubit.iconPath[6], 6,
                      ),
                      Visibility(child: Padding(
                        padding:  EdgeInsets.only(top: 15.0.h,bottom: 10.h,right: 20.w,left: 55.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E9E7E7"),
                              borderRadius: BorderRadius.circular(10)),

                          child: Padding(
                            padding:   EdgeInsets.all(8.0.w),
                            child: Directionality(
                              textDirection: ui.TextDirection.rtl,
                              child: TextField(

                                style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w600),

                                maxLines: null, // يسمح بإدخال نص متعدد الأسطر
                                scrollPhysics: AlwaysScrollableScrollPhysics(), // يمكن التمرير الأوتوماتيكي في حال كان النص يمتد عبر عدة أسطر
                              ),
                            ),
                          ),
                        ),
                      ),



                        visible: isOpen[6],),






                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.1,),

                  Row(
                    children: [
                      SizedBox(width: 5.h,),

                      Expanded(
                        child: defaultButton(
                            onPressed: () {
                              print(imageUrls);
                              print(imageUrls1);
                              print(imageUrls2);
                              print(imageUrls3);
                              print(imageUrls4);
                              print(imageUrl);
                              print(imageUrl1);
                              if(formKey.currentState!.validate()){


                                // cubit.ShiftsData(
                                //     car_Type: _chosenValue,
                                //     no_start: int.parse(readController.text),
                                //     app_charge: app_charge,
                                //     app_income: app_income,
                                //     day_data: day_data,
                                //     addby: addby,
                                //     end_path: end_path,
                                //     exp_gas: exp_gas,
                                //     exp_petrol: exp_petrol,
                                //     more_outcome: more_outcome,
                                //     no_end: int.parse(readController1.text),
                                //     notes: notes,
                                //     out_income: out_income,
                                //     start_path: start_path,
                                //     supplies: supplies,
                                //     total_time: total_time
                                //
                                // )
                              }

                            },
                            text: "ارسال",
                            width: 100.w,
                            height: 41.h,
                            fontSize: 20.sp,
                            radius: 10.r,
                            color: HexColor("#37352E")),
                      ),
                      SizedBox(width: 5.h,),

                      Expanded(
                        child: defaultButton(
                            onPressed: () {
                              navigatorTo(context, TimerScreen());
                            },
                            text: "تسجيل البدا",
                            width: 120.w,
                            height: 41.h,
                            fontSize: 18.sp,
                            radius: 10.r,
                            color: HexColor("#37352E")),
                      ),
                      SizedBox(width: 5.h,),

                      Expanded(
                        child: defaultButton(
                            onPressed: () {
                              print('is save');

                              CacheHelper.saveData(key: "istar", value: imagee) ;
                              CacheHelper.saveData(key: "nostar", value: readController.text) ;

                            },
                            text: "حفظ ",
                            width: 100.w,
                            height: 41.h,
                            fontSize: 20.sp,
                            radius: 10.r,
                            color: HexColor("#37352E")),
                      ),
                      SizedBox(width: 5.h,),

                    ],
                  ),
                  SizedBox(height: 15.h,),

                ],
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,

        ),
        listener: (context, state) {},
      ),
    );
  }


  List<String> stringsList = [];

  Future<List<String>> getListOfStrings() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('carType').get();

    querySnapshot.docs.forEach((document) {
      List<dynamic> strings = document.data()['a'];

      for (int i = 0; i < strings.length; i++) {
        stringsList.add(strings[i].toString());
      }
    });

    return stringsList;
  }





  Widget buildUserItem(
      context, String titel, String iconPath, int index ) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0.w, top: 10.h, left: 35.w),
      child: Container(
        width: double.infinity,
        height: 49.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, .5), // changes position of shadow
            )
          ],
          color: HexColor("#F8F8F8"),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 0.w,
            ),
            InkWell(
                onTap: () {
                  isOpen[index] = !isOpen[index];
                  setState(() {

                  });

                },
                child: Icon(

                  isOpen[index]?  Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp

                  ,
                  color: HexColor("#1F9615"),
                  size: 35.w,
                )),
            Container(
              height: double.infinity,
              width: 1,
              color: Colors.grey.withOpacity(.60),
            ),
            Spacer(),
            SizedBox(
              width: 8.w,
            ),
            Text(
              titel,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: HexColor("#2F2D2D"),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Image.asset(
              iconPath,
              width: 35.w,
            ),
            SizedBox(
              width: 8.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoverItem(context ){
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 15.w,),
          IconButton(onPressed: (){
            Navigator.pop(context) ;}, icon: Icon(Icons.arrow_circle_left_outlined),iconSize: 35.w,),
          Spacer(),

          Container(
            decoration: BoxDecoration(
              color: HexColor("#FBFBFB"),
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.r) ,topLeft:Radius.circular(10.r) ),

            ),
            child: Row(
              children: [
                SizedBox(width: 5.w,),
                Text("وردية جديدة",style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                SizedBox(width: 5.w,),
                Image.asset("assets/icons/Porsche 911 New.png",width: 20.w,),
                SizedBox(width: 5.w,),
                Container(
                  width:15.w ,
                  height: 45.h,
                  color: Colors.grey,

                ),




              ],
            ),

          ),


        ],
      ),

    );
  }


  Widget drobList0( ) {
    return Padding(
      padding: EdgeInsets.only(left: 120.0.w, top: 10.h, right: 60.w),
      child:
      Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(15.r)),
        child: DropdownButton<String>(
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_sharp),
          focusColor: Colors.white,
          value: _chosenValue,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: stringsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:   EdgeInsets.only(left: 8.0.w),
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          elevation: 0,
          underline: Text(""),
          hint: Text(
            "   choose a car  ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          alignment: Alignment.center,
          onChanged: (String? value) {
            _chosenValue = value!;
            setState(() {});
          },
        )
        ,
      ),
    );
  }



  Widget drobList1({  required String path, required String path2}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: MediaQuery.of(context).size.width*.4,
                height: 30.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .5,
                        blurRadius: .5,
                        offset: Offset(0, .5), // changes position of shadow
                      )
                    ],

                    color: HexColor("##FFFFFF"),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: readController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Text(
                "  : رقم العداد ",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(imagee != null)
                Image.file(imagee!, width: MediaQuery.of(context).size.width*.1,height: MediaQuery.of(context).size.height*.1,),

              SizedBox(
                width: 5.w,
              ),
              InkWell(
                  onTap: (){
                    UploadImage1(     path2:path2  , path:path ,);
                  },
                  child: Image.asset("assets/icons/driver/Upload to Cloud.png",height: 50.h,width: 50.w,)),
              Text(
                "  : رفع صورة العداد",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20.w,
              ),






            ],
          ),
        ),

      ],
    );
  }
  Widget drobList2({  required String path, required String path2} ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: MediaQuery.of(context).size.width*.4,
                height: 30.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .5,
                        blurRadius: .5,
                        offset: Offset(0, .5), // changes position of shadow
                      )
                    ],

                    color: HexColor("##FFFFFF"),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: readController1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Text(
                "  : رقم العداد ",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(imagee1 != null)
                Image.file(imagee1!, width: MediaQuery.of(context).size.width*.1,height: MediaQuery.of(context).size.height*.1,),

              SizedBox(
                width: 5.w,
              ),
              InkWell(
                  onTap: (){
                    UploadImage2(  path: path, path2: path2 ) ;
                  },
                  child: Image.asset("assets/icons/driver/Upload to Cloud.png",height: 50.h,width: 50.w,)),
              Text(
                "  : رفع صورة العداد",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20.w,
              ),







            ],
          ),
        ),

      ],
    );
  }



  Widget addItem({required int? index,required List<bool>? isexpand,required List<String>? name,required List<Widget>? rows,
    required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls}){

    return Padding(
      padding:   EdgeInsets.only(top: 10.0.h,right: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          buildAddIcon(isVisbil: isexpand![index!]  ,index: index,image: image,controllers:controllers,rows: rows,path: path,path2:path2 ,imageUrls: imageUrls ),
          SizedBox(width: 10.w,),
          InkWell(
              onTap: () {
                isexpand[index]  = !isexpand[index] ;
                setState(() {

                });

              },
              child: Icon(

                isexpand![index!] ?  Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp

                ,
                color: Colors.black,
                size: 25.w,
              )),
          Text(name![index],style: TextStyle(fontSize:19.sp,color: HexColor("#1F9615"),fontWeight: FontWeight.w500 ),),
          SizedBox(width: 5.w,),
          CircleAvatar(radius: 6,backgroundColor: Colors.grey[700] ,),
          SizedBox(width: 15.w,),



        ],
      ),
    );


  }




  Widget addItem1({required int? index,required List<bool>? isexpand,required List<String>? name,required List<Widget>? rows,
    required List<TextEditingController>? controllers, }){

    return Padding(
      padding:   EdgeInsets.only(top: 10.0.h,right: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          buildAddIcon1(isVisbil: isexpand![index!]  ,index: index, controllers:controllers,rows: rows ),
          SizedBox(width: 10.w,),
          InkWell(
              onTap: () {
                isexpand[index]  = !isexpand[index] ;
                setState(() {

                });

              },
              child: Icon(

                isexpand![index!] ?  Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp

                ,
                color: Colors.black,
                size: 25.w,
              )),
          Text(name![index],style: TextStyle(fontSize:19.sp,color: HexColor("#1F9615"),fontWeight: FontWeight.w500 ),),
          SizedBox(width: 5.w,),
          CircleAvatar(radius: 6,backgroundColor: Colors.grey[700] ,),
          SizedBox(width: 15.w,),



        ],
      ),
    );


  }

  Widget addItem2({required int? index,required List<bool>? isexpand,required List<String>? name,required List<Widget>? rows,
    required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls}){

    return Padding(
      padding:   EdgeInsets.only(top: 10.0.h,right: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          buildAddIcon2(isVisbil: isexpand![index!]  ,index: index,image: image,controllers:controllers,rows: rows,path: path,path2:path2 ,imageUrls: imageUrls ),
          SizedBox(width: 10.w,),
          InkWell(
              onTap: () {
                isexpand[index]  = !isexpand[index] ;
                setState(() {

                });

              },
              child: Icon(

                isexpand![index!] ?  Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp

                ,
                color: Colors.black,
                size: 25.w,
              )),
          Text(name![index],style: TextStyle(fontSize:19.sp,color: HexColor("#1F9615"),fontWeight: FontWeight.w500 ),),
          SizedBox(width: 5.w,),
          CircleAvatar(radius: 6,backgroundColor: Colors.grey[700] ,),
          SizedBox(width: 15.w,),



        ],
      ),
    );


  }


  Widget addItem3({required int? index,required List<bool>? isexpand,required String? name,required List<Widget>? rows,
    required List<TextEditingController>? controllers, }){

    return Padding(
      padding:   EdgeInsets.only(top: 10.0.h,right: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          buildAddIcon3(isVisbil: isexpand![index!]  ,index: index,image: image,controllers:controllers,rows: rows ),
          SizedBox(width: 10.w,),
          InkWell(
              onTap: () {
                isexpand[index]  = !isexpand[index] ;
                setState(() {

                });

              },
              child: Icon(

                isexpand![index!] ?  Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp

                ,
                color: Colors.black,
                size: 25.w,
              )),
          Text(name! ,style: TextStyle(fontSize:19.sp,color: HexColor("#1F9615"),fontWeight: FontWeight.w500 ),),
          SizedBox(width: 5.w,),
          CircleAvatar(radius: 6,backgroundColor: Colors.grey[700] ,),
          SizedBox(width: 15.w,),



        ],
      ),
    );


  }

  Widget buildappIncome({required int? index, required List<bool>? isexpand,
    required List<TextEditingController>? controllers, required List<Widget>? rows,
    required   List<File>? image,}){
    return Visibility(
      visible: isexpand![index!],
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .5,
                blurRadius: .5,
                offset: Offset(0, .5), // changes position of shadow
              )
            ],
            color: HexColor("#F8F8F8"),
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: Visibility(
            visible: rows!.length>0,
            child: Column(
              children: [
                Container(
                  color:  HexColor("#4C4B4B"),
                  child: Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("صورة الإيراد",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("القيمة",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("عدد الرحلات",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("اسم التطبيق",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      cdx = index ;

                      return rows[index];

                    },
                    separatorBuilder: (context, index) =>
                        Container(
                          height: 1.w,
                          color: Colors.white,
                          child: Text(""),
                        ),

                    itemCount: rows.length),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controllers!.removeLast();
                      controllers.removeLast();
                      if(image!.length == rows.length){
                        image.removeLast();
                      }

                      rows.removeLast();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get values'),
                  onPressed: () {
                    print(image!.length);
                    // print(image.toString());
                    if (formKey.currentState!.validate()){
                      List<String> values = [];
                      for (int i = 0; i < controllers!.length; i++) {
                        values.add(controllers[i].text); // الحصول على القيم من كل TextEditingController
                      }
                      print(values); // طباعة القيم


                    }
                  },
                ),
                Text(  "${image!.length} added images successful",style: TextStyle(color: Colors.black),),
                if(image.length>0)
                  Container(
                    height: MediaQuery.of(context).size.height*.09,
                    width: double.infinity,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Stack(
                          alignment: Alignment.topRight,
                          children: [

                            Image.file(image[index], scale: .1,),
                            InkWell(
                              onTap: () {
                                setState(() {

                                  image.removeAt(index);

                                });

                              },
                              child: Icon(Icons.delete,color: Colors.red,),
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(),
                        itemCount: image.length),
                  )


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildappOutcome1({required int? index, required List<bool>? isexpand,
    required List<TextEditingController>? controllers, required List<Widget>? rows,
    required   List<File>? image,}){
    return Visibility(
      visible: isexpand![index!],
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .5,
                blurRadius: .5,
                offset: Offset(0, .5), // changes position of shadow
              )
            ],
            color: HexColor("#F8F8F8"),
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: Visibility(
            visible: rows!.length>0,
            child: Column(
              children: [
                Container(
                  color:  HexColor("#4C4B4B"),
                  child: Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("ملف الصورة",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("نوع البند",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("التكلفة ",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),


                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      cdx = index ;

                      return rows[index];

                    },
                    separatorBuilder: (context, index) =>
                        Container(
                          height: 1.w,
                          color: Colors.white,
                          child: Text(""),
                        ),

                    itemCount: rows.length),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controllers!.removeLast();
                      controllers.removeLast();
                      if(image!.length == rows.length){
                        image.removeLast();
                      }

                      rows.removeLast();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get values'),
                  onPressed: () {
                    print(image!.length);
                    // print(image.toString());
                    if (formKey.currentState!.validate()){
                      List<String> values = [];
                      for (int i = 0; i < controllers!.length; i++) {
                        values.add(controllers[i]
                            .text); // الحصول على القيم من كل TextEditingController
                      }
                      print(values); // طباعة القيم


                    }
                  },
                ),
                Text(  "${image!.length} added images successful",style: TextStyle(color: Colors.black),),
                if(image.length>0)
                  Container(
                    height: MediaQuery.of(context).size.height*.09,
                    width: double.infinity,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Stack(
                          alignment: Alignment.topRight,
                          children: [

                            Image.file(image[index], scale: .1,),
                            InkWell(
                              onTap: () {
                                setState(() {

                                  image.removeAt(index);

                                });

                              },
                              child: Icon(Icons.delete,color: Colors.red,),
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(),
                        itemCount: image.length),
                  )


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildoutputTrips({required int? index, required List<bool>? isexpand,
    required List<TextEditingController>? controllers, required List<Widget>? rows,
  }){
    return Visibility(
      visible: isexpand![index!],
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .5,
                blurRadius: .5,
                offset: Offset(0, .5), // changes position of shadow
              )
            ],
            color: HexColor("#F8F8F8"),
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: Visibility(
            visible: rows!.length>0,
            child: Column(
              children: [
                Container(
                  color:  HexColor("#4C4B4B"),
                  child: Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("القيمة",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("عدد الرحلات",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      cdx = index ;

                      return rows[index];

                    },
                    separatorBuilder: (context, index) =>
                        Container(
                          height: 1.w,
                          color: Colors.white,
                          child: Text(""),
                        ),

                    itemCount: rows.length),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controllers!.removeLast();
                      controllers.removeLast();

                      rows.removeLast();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get values'),
                  onPressed: () {
                    // print(image.toString());
                    if (formKey.currentState!.validate()){
                      List<String> values = [];
                      for (int i = 0; i < controllers!.length; i++) {
                        values.add(controllers[i]
                            .text); // الحصول على القيم من كل TextEditingController
                      }
                      print(values); // طباعة القيم


                    }
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget buildout({required int? index, required List<bool>? isexpand,
    required List<TextEditingController>? controllers, required List<Widget>? rows,
  }){
    return  Visibility(
      visible: isexpand![index!],
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .5,
                blurRadius: .5,
                offset: Offset(0, .5), // changes position of shadow
              )
            ],
            color: HexColor("#F8F8F8"),
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: Visibility(
            visible: rows!.length>0,
            child: Column(
              children: [
                Container(
                  color:  HexColor("#4C4B4B"),
                  child: Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("طريقة التوريد ",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("المبلغ",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("المورد",style:
                            TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      cdx = index ;

                      return rows[index];

                    },
                    separatorBuilder: (context, index) =>
                        Container(
                          height: 1.w,
                          color: Colors.white,
                          child: Text(""),
                        ),

                    itemCount: rows.length),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controllers!.removeLast();
                      controllers.removeLast();

                      rows.removeLast();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get values'),
                  onPressed: () {
                    if (formKey.currentState!.validate()){
                      List<String> values = [];
                      for (int i = 0; i < controllers!.length; i++) {
                        values.add(controllers[i]
                            .text); // الحصول على القيم من كل TextEditingController
                      }
                      print(values); // طباعة القيم


                    }
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }



  UploadImage( {required List<Widget>? rows,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls}) async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if(rows!.length>image!.length){
          image.add(File(pickedImage.path));
        }
        uploadImagesShifts(photos: image, path: path, path2: path2 ,imageUrls: imageUrls);


      });
    }
  }
  UploadImage1({  required String path, required String path2}  ) async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery).then((value){
      if (value != null) {
        setState(() {
          imagee = File(value.path);

        });
        uploadImageShift(photo: imagee!, path: path, path2: path2,imageUrl: imageUrl);



      }
    });



    Widget buildAddIcon
        ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
      required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls })
    {

      return Visibility(
          visible: isVisbil!,
          child:InkWell(
            onTap: () {
              setState(() {
                controllers!.add(TextEditingController());
                controllers.add(TextEditingController());
                controllers.add(TextEditingController());
                rows!.add(Container(
                  color:  HexColor("#DCDCDC"),
                  child: Row(

                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print('is tap ');
                            UploadImage(image: image,rows: rows, path:path ,path2:path2,imageUrls: imageUrls );

                          },
                          child: Container(
                            child: Center(
                              child: Icon(Icons.cloud_upload,color: Colors.black,),
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,


                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-3],
                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-2],
                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                              child: TextFormField(


                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers.last,
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),);

              });

            },
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#57B050"),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, .5), // changes position of shadow
                    )
                  ],
                  color: HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                    Padding(
                      padding:   EdgeInsets.all(3.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: .5,
                              blurRadius: .5,
                              offset: Offset(0, .5), // changes position of shadow
                            )
                          ],
                          color: HexColor("#F8F8F8"),
                        ),
                        child: Icon(
                          color: Colors.grey,

                          Icons.add,
                          size: 15.w,
                        ),
                      ),
                    ),

                  ],
                )),
          ) );
    }



    Widget buildAddIcon1
        ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
      required List<TextEditingController>? controllers,  })
    {

      return Visibility(
          visible: isVisbil!,
          child:InkWell(
            onTap: () {
              setState(() {
                controllers!.add(TextEditingController());
                controllers.add(TextEditingController());
                rows!.add(Container(
                  color:  HexColor("#DCDCDC"),
                  child: Row(

                    children: [
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-2],
                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers.last,
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),);

              });

            },
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#57B050"),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, .5), // changes position of shadow
                    )
                  ],
                  color: HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                    Padding(
                      padding:   EdgeInsets.all(3.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: .5,
                              blurRadius: .5,
                              offset: Offset(0, .5), // changes position of shadow
                            )
                          ],
                          color: HexColor("#F8F8F8"),
                        ),
                        child: Icon(
                          color: Colors.grey,

                          Icons.add,
                          size: 15.w,
                        ),
                      ),
                    ),

                  ],
                )),
          ) );
    }





    Widget buildAddIcon2
        ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
      required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls })
    {

      return Visibility(
          visible: isVisbil!,
          child:InkWell(
            onTap: () {
              setState(() {
                controllers!.add(TextEditingController());
                controllers.add(TextEditingController());
                rows!.add(Container(
                  color:  HexColor("#DCDCDC"),
                  child: Row(

                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print('is tap ');
                            UploadImage(image: image,rows: rows, path:path ,path2:path2 ,imageUrls: imageUrls);

                          },
                          child: Container(
                            child: Center(
                              child: Icon(Icons.cloud_upload,color: Colors.black,),
                            ),

                          ),
                        ),
                      ),

                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(


                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-2],

                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers.last,
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),);

              });

            },
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#57B050"),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, .5), // changes position of shadow
                    )
                  ],
                  color: HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                    Padding(
                      padding:   EdgeInsets.all(3.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: .5,
                              blurRadius: .5,
                              offset: Offset(0, .5), // changes position of shadow
                            )
                          ],
                          color: HexColor("#F8F8F8"),
                        ),
                        child: Icon(
                          color: Colors.grey,

                          Icons.add,
                          size: 15.w,
                        ),
                      ),
                    ),

                  ],
                )),
          ) );
    }


    Widget buildAddIcon3
        ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
      required List<TextEditingController>? controllers,required   List<File>? image, })
    {

      return Visibility(
          visible: isVisbil!,
          child:InkWell(
            onTap: () {
              setState(() {
                controllers!.add(TextEditingController());
                controllers.add(TextEditingController());
                controllers.add(TextEditingController());
                rows!.add(Container(
                  color:  HexColor("#DCDCDC"),
                  child: Row(

                    children: [
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(


                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-3],
                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "يجب ادخال قيمة " ;

                                    }
                                  },

                                  decoration: InputDecoration(
                                      hintText: 'اضف قيمة ',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )

                                  ),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                  controller: controllers[controllers.length-2],
                                )
                            ),

                          ),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white,
                        child: Text(""),
                      ),
                      Expanded(
                        child: Padding(
                          padding:   EdgeInsets.all(2.0.h),
                          child: Container(
                            child: Center(
                              child: TextFormField(


                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers.last,
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),);

              });

            },
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#57B050"),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, .5), // changes position of shadow
                    )
                  ],
                  color: HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                    Padding(
                      padding:   EdgeInsets.all(3.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: .5,
                              blurRadius: .5,
                              offset: Offset(0, .5), // changes position of shadow
                            )
                          ],
                          color: HexColor("#F8F8F8"),
                        ),
                        child: Icon(
                          color: Colors.grey,

                          Icons.add,
                          size: 15.w,
                        ),
                      ),
                    ),

                  ],
                )),
          ) );
    }


  }
  UploadImage2({  required String path, required String path2} ) async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery).then((value){
      if (value != null) {
        setState(() {
          imagee1 = File(value.path);

        });
        uploadImageShift(photo: imagee1!, path: path, path2: path2,imageUrl: imageUrl);



      }
    });




  }





  Widget buildAddIcon
      ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
    required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2,required List<String> imageUrls })
  {

    return Visibility(
        visible: isVisbil!,
        child:InkWell(
          onTap: () {
            setState(() {
              controllers!.add(TextEditingController());
              controllers.add(TextEditingController());
              controllers.add(TextEditingController());
              rows!.add(Container(
                color:  HexColor("#DCDCDC"),
                child: Row(

                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('is tap ');
                          UploadImage(image: image,rows: rows, path:path ,path2:path2 ,imageUrls: imageUrls);

                        },
                        child: Container(
                          child: Center(
                            child: Icon(Icons.cloud_upload,color: Colors.black,),
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,


                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-3],
                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,

                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-2],
                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                            child: TextFormField(


                              decoration: InputDecoration(
                                  hintText: 'اضف قيمة ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "يجب ادخال قيمة " ;

                                }
                              },

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                              controller: controllers.last,
                            ),
                          ),

                        ),
                      ),
                    ),


                  ],
                ),
              ),);

            });

          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#57B050"),
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, .5), // changes position of shadow
                  )
                ],
                color: HexColor("#F8F8F8"),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 5.w,),
                  Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                  Padding(
                    padding:   EdgeInsets.all(3.0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, .5), // changes position of shadow
                          )
                        ],
                        color: HexColor("#F8F8F8"),
                      ),
                      child: Icon(
                        color: Colors.grey,

                        Icons.add,
                        size: 15.w,
                      ),
                    ),
                  ),

                ],
              )),
        ) );
  }



  Widget buildAddIcon1
      ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
    required List<TextEditingController>? controllers,  })
  {

    return Visibility(
        visible: isVisbil!,
        child:InkWell(
          onTap: () {
            setState(() {
              controllers!.add(TextEditingController());
              controllers.add(TextEditingController());
              rows!.add(Container(
                color:  HexColor("#DCDCDC"),
                child: Row(

                  children: [
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-2],
                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                  hintText: 'اضف قيمة ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "يجب ادخال قيمة " ;

                                }
                              },

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                              controller: controllers.last,
                            ),
                          ),

                        ),
                      ),
                    ),


                  ],
                ),
              ),);

            });

          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#57B050"),
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, .5), // changes position of shadow
                  )
                ],
                color: HexColor("#F8F8F8"),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 5.w,),
                  Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                  Padding(
                    padding:   EdgeInsets.all(3.0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, .5), // changes position of shadow
                          )
                        ],
                        color: HexColor("#F8F8F8"),
                      ),
                      child: Icon(
                        color: Colors.grey,

                        Icons.add,
                        size: 15.w,
                      ),
                    ),
                  ),

                ],
              )),
        ) );
  }





  Widget buildAddIcon2
      ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
    required List<TextEditingController>? controllers,required   List<File>? image,required  String path,required   String path2, required List<String> imageUrls})
  {

    return Visibility(
        visible: isVisbil!,
        child:InkWell(
          onTap: () {
            setState(() {
              controllers!.add(TextEditingController());
              controllers.add(TextEditingController());
              rows!.add(Container(
                color:  HexColor("#DCDCDC"),
                child: Row(

                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('is tap ');
                          UploadImage(image: image,rows: rows, path:path ,path2:path2,imageUrls: imageUrls );

                        },
                        child: Container(
                          child: Center(
                            child: Icon(Icons.cloud_upload,color: Colors.black,),
                          ),

                        ),
                      ),
                    ),

                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(


                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-2],

                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                  hintText: 'اضف قيمة ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "يجب ادخال قيمة " ;

                                }
                              },

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                              controller: controllers.last,
                            ),
                          ),

                        ),
                      ),
                    ),


                  ],
                ),
              ),);

            });

          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#57B050"),
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, .5), // changes position of shadow
                  )
                ],
                color: HexColor("#F8F8F8"),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 5.w,),
                  Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                  Padding(
                    padding:   EdgeInsets.all(3.0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, .5), // changes position of shadow
                          )
                        ],
                        color: HexColor("#F8F8F8"),
                      ),
                      child: Icon(
                        color: Colors.grey,

                        Icons.add,
                        size: 15.w,
                      ),
                    ),
                  ),

                ],
              )),
        ) );
  }


  Widget buildAddIcon3
      ({required bool ? isVisbil, required int? index ,required List<Widget>? rows,
    required List<TextEditingController>? controllers,required   List<File>? image, })
  {

    return Visibility(
        visible: isVisbil!,
        child:InkWell(
          onTap: () {
            setState(() {
              controllers!.add(TextEditingController());
              controllers.add(TextEditingController());
              controllers.add(TextEditingController());
              rows!.add(Container(
                color:  HexColor("#DCDCDC"),
                child: Row(

                  children: [
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(


                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-3],
                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,

                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "يجب ادخال قيمة " ;

                                  }
                                },

                                decoration: InputDecoration(
                                    hintText: 'اضف قيمة ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )

                                ),

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                                controller: controllers[controllers.length-2],
                              )
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      color: Colors.white,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.all(2.0.h),
                        child: Container(
                          child: Center(
                            child: TextFormField(


                              decoration: InputDecoration(
                                  hintText: 'اضف قيمة ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "يجب ادخال قيمة " ;

                                }
                              },

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                              controller: controllers.last,
                            ),
                          ),

                        ),
                      ),
                    ),


                  ],
                ),
              ),);

            });

          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#57B050"),
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, .5), // changes position of shadow
                  )
                ],
                color: HexColor("#F8F8F8"),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 5.w,),
                  Text("اضافة ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp, color: HexColor("#57B050")),),
                  Padding(
                    padding:   EdgeInsets.all(3.0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, .5), // changes position of shadow
                          )
                        ],
                        color: HexColor("#F8F8F8"),
                      ),
                      child: Icon(
                        color: Colors.grey,

                        Icons.add,
                        size: 15.w,
                      ),
                    ),
                  ),

                ],
              )),
        ) );
  }






  Future<List<String>> uploadImagesShifts({required List<File> photos,required String path,required String path2,required List<String> imageUrls } ) async {
    imageUrls = [] ;
    for (int i = 0; i < photos.length; i++) {
      File image = photos[i];

      // Create a reference to the Firebase Storage path where the image will be uploaded
      Reference storageReference =
      FirebaseStorage.instance.ref().child("images/${uId}/Shifts/${path2}/${path}/image$i.jpg");

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;

      // Get the download URL of the uploaded image
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    print(imageUrls);

    return imageUrls;
  }

  Future<String> uploadImageShift({required File photo, required String path, required String path2 ,required String imageUrl , }) async {
    // Create a reference to the Firebase Storage path where the image will be uploaded
    Reference storageReference =
    FirebaseStorage.instance.ref().child("images/${uId}/Shifts/${path2}/${path}/image.jpg");

    // Upload the image to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(photo);
    await uploadTask;

    // Get the download URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }


}
