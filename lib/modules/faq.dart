import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/modules/login/cubit/cubit.dart';
import 'package:logo/modules/login/cubit/states.dart';
import 'package:logo/modules/soon.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/cubit/cubit.dart';
import 'package:logo/shared/cubit/states.dart';

class FAQ extends StatefulWidget {
  FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  var formKey = GlobalKey<FormState>();

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
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
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
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
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
                                  "اسالة شائعة",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Icon(
                                  Icons.question_mark_rounded,
                                  size: 25.h,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                          height: 550.h,
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildUserItem(
                                      context, cubit.faq[index], index,  ),
                              separatorBuilder: (context, index) => Visibility(
                                    visible:  isOpen[index],
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 35.0.w, left: 40.w, top: 10.h),
                                      child: Text(
                                         faqa[index],
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                              itemCount: cubit.faq.length)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }
  List<String> faqa = [
    "ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات20 ",
    "ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات30 ",
    "ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات40 ",
    " 50ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ملاحظات ",
    "gf"
  ];

  List<bool> isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Widget buildUserItem(context, String titel, int index) {
    return Padding(
      padding: EdgeInsets.only(right: 27.0.w, top: 10.h, left: 30.w),
      child: Container(
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
                  setState(() {});
                },
                child: Icon(
                  isOpen[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down_sharp,
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
                fontSize: 14.sp,
                color: HexColor("#418F3A"),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              ": ${index + 1} س",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 8.w,
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
                  "FAQ",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Image.asset(
                  "assets/icons/Questions (1).png",
                  width: 20.w,
                ),
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
}
