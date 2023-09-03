import 'dart:math' as m;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/modules/messages_screen.dart';
import 'package:logo/modules/messages_to_screen.dart';
import 'package:logo/modules/soon.dart';
import 'package:logo/modules/user_screen.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/componant/constant.dart';
import 'package:logo/shared/cubit/cubit.dart';
import 'package:logo/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:logo/shared/network/local/cache_helper.dart';

import '../models/messages_model.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Appcubit.get(context).getMessagesData;
     print('do');
    uId = CacheHelper.getData(key: "uId") ;

   }

   final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    var fh = MediaQuery.of(context).size.height;
    var fw = MediaQuery.of(context).size.width;

    var cubit = Appcubit.get(context);
    var now = DateTime.now();
    var dateFormatter = DateFormat('yyyy-MM-dd');
    var timeFormatter = DateFormat('hh:mm a');
    var formattedDate = dateFormatter.format(now);
    var formattedTime = timeFormatter.format(now);

    Stream collectionStream = FirebaseFirestore.instance
        .collection('messagesWith/${formattedDate}/${formattedDate}')
        .orderBy('timestamp', descending: true)
        .snapshots();



    Stream collectionStream1 = FirebaseFirestore.instance
        .collection('messagesTo/${formattedDate}/${formattedDate}')
        .orderBy('timestamp', descending: true)
        .snapshots();

    var arabicWeekday = DateFormat('EEEE', 'ar');
    var formattedWeekday = arabicWeekday.format(now);

    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        key: _key,
        backgroundColor: HexColor("#F5F5F5"),
        appBar: AppBar(
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
          actions: [
            IconButton(
                onPressed: () {

                  _key.currentState!.openEndDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 29.w,
                ))
          ],
        ),
        endDrawer: Padding(
            padding: EdgeInsets.only(top: 76.h),
            child: Drawer(
              backgroundColor: Colors.transparent,
              width: 200.w,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F5F5F5"),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.h,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => builtDrawerIteam(
                                  name: cubit.nameDrawer[index],
                                  icon: cubit.iconPathDrawer[index],
                                  screen: cubit.screens[index],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 30.h,
                                ),
                            itemCount: cubit.nameDrawer.length),
                        SizedBox(
                          height: 30.h,
                        ),
                        builtDrawerSingOutIteam(
                            name: "الخروج",
                            icon: "assets/icons/home/logout.png"),
                        SizedBox(
                          height: 41.h,
                        ),
                        Text(
                          "commuter",
                          style: TextStyle(
                            color: HexColor("#666666"),
                            fontSize: 18.sp,
                            fontFamily: "Harlow",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        body: Container(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0.w),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: fw * .4.w),
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: HexColor("#484646"),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text("الصفحة الرئيسية",
                                style: GoogleFonts.inter(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Icon(
                            Icons.home,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: fw * .57),
                    child: Container(
                      width: 131.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          )
                        ],
                        color: HexColor("#FAFAFA"),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text("رسائل عاجلة",
                                  style: GoogleFonts.laila(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              'assets/icons/Communication.png',
                              width: 21.w,
                              height: 17.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  StreamBuilder(
                    stream: collectionStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("error");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Text(
                          "Loading....",
                          style: TextStyle(fontSize: 30.sp, color: Colors.red),
                        ));
                      }
                      if (snapshot.hasData) {
                        messagesList = [];
                        snapshot.data!.docs.forEach((element) {
                          messagesList
                              .add(MessagesModel.fromJson(element.data()));
                        });
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemBuilder: (context, index) {
                            return builtMassegeIteam(
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
                            );
                          },
                          itemCount: messagesList.length,
                        );
                      }
                      return Text("mahmoud");
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      defaultButton(
                          onPressed: () {
                            navigatorTo(context, MessagesScreen());
                          },
                          text: "كل الرسائل",
                          width: 100.w,
                          height: 23.h,
                          radius: 5.r,
                          color: HexColor("#666666"),
                          fontSize: 12.sp)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: fw * .57),
                    child: Container(
                      width: 131.w,
                      height: 29.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          )
                        ],
                        color: HexColor("#FAFAFA"),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text("رسائل هامة",
                                  style: GoogleFonts.laila(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              'assets/icons/Communication.png',
                              width: 21.w,
                              height: 17.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  StreamBuilder(
                    stream: collectionStream1,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("error");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Text(
                              "Loading....",
                              style: TextStyle(fontSize: 30.sp, color: Colors.red),
                            ));
                      }
                      if (snapshot.hasData) {
                        messagesList = [];
                        snapshot.data!.docs.forEach((element) {
                          messagesList
                              .add(MessagesModel.fromJson(element.data()));
                        });
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemBuilder: (context, index) {

                             return builtMassegeIteam1(
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
                               to: snapshot.data!.docs[index].data()['to'] ,
                            );
                          },
                          itemCount: messagesList.length,
                        );
                      }
                      return Text("mahmoud");
                    },
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      defaultButton(
                          onPressed: () {
                            navigatorTo(context, MessagesToScreen());
                          },
                          text: "كل الرسائل",
                          color: HexColor("#666666"),
                          width: 100.w,
                          height: 23.h,
                          radius: 5.r,
                          fontSize: 12.sp)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print(Timestamp.now());
                          print('$formattedWeekday');
                          print('$formattedDate');
                          print(   CacheHelper.getData(key: "uId"));

                        },
                        child: Text("التعليمات",
                            style: GoogleFonts.laila(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4.h,
                      crossAxisSpacing: 4.w,
                      childAspectRatio: 1.2.h,
                    ),
                    itemBuilder: (context, index) => builtInstIteam(
                        name: cubit.nameInst[index],
                        icon: cubit.iconPathInst[index]),
                    itemCount: 6,
                  ),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(CacheHelper.getData(key: "uId"));
            print(uId);
            cubit.MessagesAllCreate(
                name: formattedDate, nameday: formattedWeekday);

            cubit.MessagesToCreate(
              nameday:formattedWeekday ,
              name: formattedDate,
            );

            cubit.MessageAllCreate(
                dataname: formattedDate,
                name: "اذهب حالا",
                time: formattedTime,
                addby: "mahmoud",
                path: formattedDate,
                nameday: formattedWeekday,
                isread: {"${uId}": false});
            cubit.MessagetoCreate(
                name: "يافولان اذهب ",
                dataname: formattedDate,
                time: formattedTime,
                addby: "mahmoud",
                nameday: formattedWeekday,
                to: uId,
                path: formattedDate,
                isread: {"${uId}": false});
          },
        ),
      ),
    );
  }



  List<MessagesModel> messagesList = [];

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isread.values.first != true
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
                    color: isread.values.first != true
                        ? HexColor("#FAFAFA")
                        : HexColor("#EDEEEE").withOpacity(.50),
                  ),
                  child: IconButton(
                    onPressed: ()   {
                      updateMapValue(path, id, uId!) ;

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
                      backgroundColor: isread.values.first != true
                          ? HexColor("##DC1111")
                          : Colors.grey,
                    ),
                    CircleAvatar(
                      radius: 6.r,
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      radius: 3.r,
                      backgroundColor: isread.values.first != true
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
    );
  }


  Widget builtMassegeIteam1({
    required int index,
    required String day,
    required String to,
    required String path,
    required String message,
    required String addby,
    required String clock,
    required String id,
    required Map<String, dynamic> isread,
  }) {
    return Visibility(
      visible: to == uId,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isread.values.first != true
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
                      color: isread.values.first != true
                          ? HexColor("#FAFAFA")
                          : HexColor("#EDEEEE").withOpacity(.50),
                    ),
                    child: IconButton(
                      onPressed: ()   {
                        updateMapValueTo(path, id, uId!) ;

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
                        backgroundColor: isread.values.first != true
                            ? HexColor("##DC1111")
                            : Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 6.r,
                        backgroundColor: Colors.white,
                      ),
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: isread.values.first != true
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


  Widget builtInstIteam({
    @required String? name,
    @required String? icon,
  }) {
    return InkWell(
      onTap: () => dialogtInstShow(),
      child: Container(
        width: 105.w,
        height: 70.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
          color: HexColor("#FAFAFA"),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Image.asset(
              icon!,
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              name!,
              style: TextStyle(fontSize: 20.sp, color: HexColor("#747171")),
            )
          ],
        ),
      ),
    );
  }

  Widget builtDrawerIteam(
      {@required String? name,
      @required String? icon,
      @required Widget? screen}) {
    return Padding(
      padding: EdgeInsets.only(right: 14.0.w),
      child: InkWell(
        onTap: () => navigatorTo(context, screen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 5.w,
            ),
            Image.asset(
              icon!,
              width: 20.w,
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget builtDrawerSingOutIteam({
    @required String? name,
    @required String? icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 14.0.w),
      child: InkWell(
        onTap: () => singOut(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 5.w,
            ),
            Image.asset(
              icon!,
              width: 20.w,
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dialogtInstShow() {
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
                      "تعليمات حزام الأمان",
                      style: TextStyle(
                        color: HexColor("#1F9615"),
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: HexColor("#CECECE"),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "جيب وضع الحزام علي مدار الرحله",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#868181"),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 2.r,
                              backgroundColor: HexColor("#CECECE"),
                            ),
                            CircleAvatar(
                              radius: 4.r,
                              backgroundColor: HexColor("##FFFFFF"),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "جيب وضع الحزام علي مدار الرحله",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#868181"),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 2.r,
                              backgroundColor: HexColor("#CECECE"),
                            ),
                            CircleAvatar(
                              radius: 4.r,
                              backgroundColor: HexColor("##FFFFFF"),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                      ],
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

  void updateMapValue(String path, String id, String uId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('messagesWith/${path}/${path}').doc(id);
    DocumentSnapshot doc = await docRef.get();
    Map<String, dynamic> currentData = doc.data() as Map<String, dynamic>;
    currentData['map1'][uId] = true;
    docRef.update(currentData);
  }

  void updateMapValueTo(String path, String id, String uId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('messagesTo/${path}/${path}').doc(id);
    DocumentSnapshot doc = await docRef.get();
    Map<String, dynamic> currentData = doc.data() as Map<String, dynamic>;
    currentData['map1'][uId] = true;
    docRef.update(currentData);
  }



  Future<void> dialogtMsnShow({required String message}) {
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
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
