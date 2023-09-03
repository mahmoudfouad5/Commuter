import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/modules/daily_reports.dart';
import 'package:logo/modules/login/cubit/cubit.dart';
import 'package:logo/modules/login/cubit/states.dart';
import 'package:logo/modules/monthly_reports.dart';
import 'package:logo/modules/soon.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/cubit/cubit.dart';
import 'package:logo/shared/cubit/states.dart';

class Reports extends StatelessWidget {
  Reports({Key? key}) : super(key: key);
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
                                  offset: Offset(0, 2), // changes position of shadow
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
                                  "اختيار نوع التقرير",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.sp),
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
                      buildUserItem(   "تقرير شهري/ اسبوعي",   () {navigatorTo(context, MonthlyReports());  }),
                      SizedBox(height: 15.h,),
                      buildUserItem(   "تقرير يومي",   () {navigatorTo(context, DailyReports()); }),
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

  Widget buildUserItem(
        String titel, VoidCallback change) {
    return Padding(
      padding:  EdgeInsets.only(left: 100.0.w,right: 25.w),
      child: InkWell(
        onTap: change,
        child: Container(
          width: double.infinity,
          height: 60.h,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 0.w,
              ),
                SizedBox(
                width: 8.w,
              ),
              Text(
                titel,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: HexColor("#418F3A"),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
               CircleAvatar(radius: 7.r,backgroundColor: Colors.grey[300],),
               SizedBox(
                width: 8.w,
              ),
            ],
          ),
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
                  "تقرير",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  width: 5.w,
                ),
                 Icon(Icons.sticky_note_2_sharp,color: HexColor("#418F3A"), ),
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
