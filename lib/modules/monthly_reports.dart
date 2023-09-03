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

class MonthlyReports extends StatelessWidget {
  MonthlyReports({Key? key}) : super(key: key);
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
          body: Container(
            width: double.infinity,
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: builtHeadItem(head: "المجموع"),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: builtHeadItem(head: "البند"),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: builtHeadItem(head: "المجموع"),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: builtHeadItem(head: "البند"),
                      ),
                    ),


                  ],
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(


                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 4.2 ,),
                      itemCount:cubit.moTitles.length,


                      itemBuilder: (context, index) => builtItem(
                          name: cubit.moTitles[index],
                          context: context,result:
                      cubit.moResult.length > index ? cubit.moResult[index]:cubit.isnull ),

                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }

  Widget builtHeadItem ({@required String? head,}){

    return   Container(
      width: 70.w,
      height: 39.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey ,
            spreadRadius: 0,
            blurRadius:4,
            offset: Offset(0, -1), // changes position of shadow
          )
        ],
        color: HexColor("#FAFAFA"),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.0.w),
        child: Center(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(head!,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ),
              ],
          ),
        ),
      ),
    );

  }

  Widget builtItem ({@required String? name,@required String? result,context}){

    return Container(
      width: MediaQuery.of(context).size.width /2,
      child: Row(
         children: [
          SizedBox(width: 5.w,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#EEEEEE"),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
                color: HexColor("#7B7B7B"),
               ),
               child: Center(
                 child: Text(name!,overflow: TextOverflow.visible,style: TextStyle(fontSize: 12.sp),textAlign: TextAlign.center),
               ),

               height: 50.h,


            ),
          ),
          SizedBox(width: 5.w,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("#EEEEEE"),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
                color: Colors.grey[350],
               ),

              height: 50.h,
               child: Center(
                child: Text(

                    result!
                    ,overflow: TextOverflow.visible,style: TextStyle(fontSize: 13.sp,color: HexColor("#1F9615"),fontWeight: FontWeight.w700),textAlign: TextAlign.center),
              ),



            ),
          ),
           SizedBox(width: 5.w,),


         ],
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
                  "تقرير شهري/ اسبوعي",
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
