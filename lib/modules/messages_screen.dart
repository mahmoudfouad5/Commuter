import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/models/message_model.dart';
import 'package:logo/models/messages_model.dart';
import 'package:logo/modules/daily_reports.dart';
import 'package:logo/modules/login/cubit/cubit.dart';
import 'package:logo/modules/login/cubit/states.dart';
import 'package:logo/modules/monthly_reports.dart';
import 'package:logo/modules/soon.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/componant/constant.dart';
import 'package:logo/shared/cubit/cubit.dart';
import 'package:logo/shared/cubit/states.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var formKey = GlobalKey<FormState>();

  int selectedIndex = -1;
  Stream collectionStream =FirebaseFirestore.instance.collection('messagesWith').orderBy('timestamp', descending: true).limit(7).snapshots();

  List<MessagesModel> messagesList = [];
  List<MessageModel> messageList = [];

  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);

    return BlocProvider(
      create: (context) => Appcubit.get(context),
      child: BlocConsumer<Appcubit, AppStates>(
        builder: (context, state) => Scaffold(
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
          backgroundColor: HexColor("#F5F5F5"),
          body: Container(
            width: double.infinity,

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

                StreamBuilder(
                  stream: collectionStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Text("error") ;
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: Text("Loading....",style: TextStyle(fontSize: 30.sp,color: Colors.red),));
                    }
                    if(snapshot.hasData){
                      messagesList = [] ;
                      snapshot.data!.docs.forEach((element) {
                        messagesList.add(MessagesModel.fromJson(element.data()));


                      });
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        itemBuilder: (context, index) => builtIteam(index,messagesList[index]),
                        itemCount: messagesList.length,
                      );
                    }
                    return Text("mahmoud");
                  }
                  ,
                ) ,





              ],
            ),
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }

 Widget buildHeadItem(){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 15.w),
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          color: HexColor("#37352E"),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              )
            ],

            borderRadius: BorderRadius.circular(
              15.r
         ),

        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 15.w,),
          Text("6/4/2023 ",style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w400),),
          Spacer(),
          Text("اليوم ",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w400),),
          SizedBox(width: 5.w,),
           Image.asset("assets/icons/Communication (1).png",scale: .8.h,),
           SizedBox(width: 5.w,),


        ],
        ),
      ),
    );
 }

 Widget builtIteam(int index, MessagesModel data){

   Stream subcollectionStream =FirebaseFirestore.instance.collection('messagesWith/${data.name}/${data.name}').orderBy('timestamp', descending: true). snapshots();

   return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 15.w),
          child: Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
              color: HexColor("#37352E"),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                )
              ],

              borderRadius: BorderRadius.circular(
                  15.r
              ),

            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 15.w,),
                Text(data.name!,style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w400),),
                Spacer(),
                Text( data.nameday!,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w400),),
                SizedBox(width: 5.w,),
                Image.asset("assets/icons/Communication (1).png",scale: .8.h,),
                SizedBox(width: 5.w,),


              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: subcollectionStream,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text("error") ;
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Text("Loading....",style: TextStyle(fontSize: 30.sp,color: Colors.red),));
            }
            if(snapshot.hasData){
              messageList = [] ;
              snapshot.data!.docs.forEach((element) {
                messageList.add(MessageModel.fromJson(element.data()));


              });
              return    ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                itemBuilder: (context, index) => builtMassegeIteam(
                    addby: snapshot.data!.docs[index].data()['addby'],
                    message:
                    snapshot.data!.docs[index].data()['name'],
                    clock: snapshot.data!.docs[index].data()['time'],
                    isread: snapshot.data!.docs[index].data()['map1'],
                    index: index,
                    day: snapshot.data!.docs[index].data()['nameday'],
                    path:
                    snapshot.data!.docs[index].data()['dataname'],
                    id: snapshot.data!.docs[index].id,
                   ),
                itemCount: messageList.length,
              );
            }
            return Text("mahmoud");
          }
          ,
        ),


      ],
    );
 }

  Widget builtMassegeIteam({
    required int index,
    required String day,
    required String path,
    required String message,
    required String addby,
    required String clock,
    required String id,
    required Map<String, dynamic> isread,
  }) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isread.values.last != true
                  ? Colors.red.withOpacity(0.4)
                  : Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            )
          ],
          color: isread.values.first != true
              ? HexColor("#FAFAFA")
              : HexColor("#EDEEEE").withOpacity(.11),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w),
                child: Container(
                    height: 40.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1.r,
                          blurRadius: 1.r,
                          offset: Offset(0.h, 2.w), // changes position of shadow
                        )
                      ],
                      color: (index == selectedIndex)
                          ? HexColor("#FAFAFA")
                          : HexColor("#EDEEEE").withOpacity(.50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        updateMapValue(path, id, uId!);

                        dialogtMsnShow(message: message);
                      },
                      icon: Icon(
                        Icons.login_outlined,
                        size: 20.w,
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "  إسم المرسل : ${addby}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "  ${clock}   يوم الارسال :  ${day}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: HexColor("#6B6E72"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 7.r,
                        backgroundColor: (index == selectedIndex)
                            ? HexColor("##DC1111")
                            : Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 6.r,
                        backgroundColor: Colors.white,
                      ),
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: (index == selectedIndex)
                            ? HexColor("##DC1111")
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildCoverItem(context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 15.w,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_circle_left_outlined),
            iconSize: 35.w,
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#FBFBFB"),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "   الرسائل",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  width: 5.w,
                ),
                 Image.asset("assets/icons/Messaging.png"),
                 SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 15.w,
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

  void updateMapValue(String path, String id, String uId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('messagesWith/${path}/${path}').doc(id);
    DocumentSnapshot doc = await docRef.get();
    Map<String, dynamic> currentData = doc.data() as Map<String, dynamic>;
    currentData['map1'][uId] = true;
    docRef.update(currentData);
  }

  Future<void> dialogtMsnShow ({required String message}){
    return showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 268.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: HexColor("#DFE0E3"),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "المرسل",
                  style: TextStyle(
                    color: HexColor("#1F9615"),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding:   EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: HexColor("#868181"),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 41.h,
                ),
                defaultButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "حسناً",
                  color: HexColor("#FFFFFF"),
                  fontSize: 16.sp,
                  radius: 5.r,
                  height: 30.h,
                  width: 65.w,
                  textColor: HexColor("#1F9615"),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ));
  }

}
