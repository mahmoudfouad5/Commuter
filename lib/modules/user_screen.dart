import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/modules/user_data_screen.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/cubit/cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context) ;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
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
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/Rectangle 32.png",
                        width: double.infinity, fit: BoxFit.cover),
                    Container(
                      width: double.infinity,
                      height: 75.h,
                      color: HexColor("#F5F5F5"),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                         Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green,
                              width: 3.0.w,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Your action here
                            },
                            icon: Icon(
                              size: 30.w,
                              Icons.camera_alt,
                              color: HexColor("#1F9615"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.w,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 114.r,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 16.r,
                        offset: Offset(3.w, 5.h),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/Ellipse 84.png"),
                    radius: 100.r,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            Text(
              "السائق",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: HexColor("#2C9C23"),
              ),
            ),
             Text(
              "مالك احمد",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32.sp,
                color: Colors.black,
              ),
            ),
             ListView.separated(
              itemCount: 3 ,
              separatorBuilder:(context, index) => SizedBox(height: 15.h,) ,
              itemBuilder: (context, index) => buildUserItem(context,icon: cubit.iconPathUser[index],name: cubit.nameUser[index],),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

            ),
            Spacer(),
            Row(

              children: [
                SizedBox(width: 20.h,),

                defaultButton(onPressed: (){
                  Navigator.pop(context);
                },
                    text: "الرجوع",
                    width: 100.w,
                    height: 40.h,
                    fontSize: 20.sp,
                    radius: 10.r,
                    color: HexColor("#37352E")),

              ],
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }

  Widget buildUserItem(context,{@required String?  name , @required String ? icon , }) {
    return InkWell(
      onTap: () {
        navigatorTo(context, UserDataScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0.w),
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
                width: 20.w,
              ),
              Icon(
                Icons.arrow_back_ios,
                color: HexColor("#1F9615"),
                size: 20.w,
              ),
              Spacer(),
              SizedBox(
                width: 8.w,
              ),
              Text(
                name!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: HexColor("#595858"),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Image.asset(icon!, height: 30.h,),
              SizedBox(
                width: 8.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
