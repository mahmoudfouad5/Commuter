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

class SessionsScreen extends StatelessWidget {
  SessionsScreen({Key? key}) : super(key: key);
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
              Form(
                key: formKey,
                child: Container(
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
                       ],
                    ),
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
   Widget buildCoverItem(context ){
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 15.w,),
           IconButton(onPressed: (){Navigator.pop(context) ;}, icon: Icon(Icons.arrow_circle_left_outlined),iconSize: 35.w,),
           Spacer(),

          Container(
            decoration: BoxDecoration(
              color: HexColor("#FBFBFB"),
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.r) ,topLeft:Radius.circular(10.r) ),

            ),
            child: Row(
              children: [
                SizedBox(width: 5.w,),
                Text("الدورات ",style: TextStyle(color: Colors.black,fontSize: 20.sp),),
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
}
