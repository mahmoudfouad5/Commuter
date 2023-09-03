import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/shared/componant/components.dart';

class UserDataScreen extends StatelessWidget {
    UserDataScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController(text: 'example value');

    var formKey = GlobalKey<FormState>();





    @override
  Widget build(BuildContext context) {
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
                    Stack(
                      children: [
                        Image.asset("assets/images/Rectangle 32.png",
                            width: double.infinity, fit: BoxFit.cover,height: 140.h,),
                        Transform.scale(
                          scale: .7,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0.w,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);


                              },
                              icon: Icon(
                                size: 25.w,
                                Icons.arrow_back,
                                color: Colors.white,
                              ),

                            ),
                          ),
                        ),

                      ],
                    ),
                   ],
                ),
               ],
            ),
               Padding(
                padding:   EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Row(
                  children: [
                     Spacer(),
                    Text("بيانات المستخدم",style: TextStyle(
                      color: HexColor("#3F3D3D"),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,

                    ),),
                    SizedBox(width: 5.w,),
                    Icon(Icons.person_pin,size:29.w ,color: HexColor("#1F9615"),),
                    SizedBox(height:15.h ,),


                  ],
                ),
              ),
             Expanded(
               child: ListView(

                 physics: NeverScrollableScrollPhysics(),
                 children: [

                   titelItem(name: "اسم المستخدم"),
                    contantItem(name: "مالك احمد "),
                   titelItem(name:"رقم الهاتف" ),
                   contantItem(name:"01274832298" ),
                   titelItem(name:"البريد الالكتروني" ),
                   contantItem(name: "malak @gmail.com"),
                   titelItem(name: "العنوان"),
                   contantItem(name:"مدينه نصر , شارع مكرم عبيد" ),
                   titelItem(name:"كلمة المرور " ),
                   contantItem(name:"********" ),
                   Padding(
                     padding:   EdgeInsets.only(right: 25.0.w,top: 5.h),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(
                           "تغير كلمة المرور",
                           style: TextStyle(
                             fontWeight: FontWeight.w500,
                             fontSize: 13.sp,
                             color: HexColor("#2C9C23"),
                           ),
                         ),

                       ],
                     ),
                   ),

                   titelItem(name:"نوع السيارة" ),
                   contantItem(name: "black Verna"),





                 ],
               ),
             ),
             Row(

              children: [
                SizedBox(width: 20.h,),


              ],
            ),
            SizedBox(height: 10.h,)
           ],
        ),
      ),
    );
  }



  
  Widget titelItem({@required String?name}){
    
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 18.0.w),
      child: Row(

        children: [
          Spacer(),
          Text(name!,style: TextStyle(
            fontSize: 16.sp,
            fontWeight:FontWeight.w400 ,
            color:Colors.grey[700] ,

          ),),
          SizedBox(width: 5.w,),
          CircleAvatar(radius:5.r ,backgroundColor: HexColor("#61606042"),),

        ],
      ),
    );
  }

  Widget contantItem({@required String?name}){

      return Padding(
        padding:   EdgeInsets.only(right: 18.0.w,left: 74.w),
        child: Container(
           height: 34.h,
           decoration:  BoxDecoration(
             boxShadow: [
               BoxShadow(
                 color:

                       Colors.grey.withOpacity(0.4),
                 spreadRadius:  0,
                 blurRadius: 0,
                 offset: Offset(1,1), // changes position of shadow
               )
             ],
             color: HexColor("#EDEEEE").withOpacity(.11),
             borderRadius: BorderRadius.circular(10.r),
           ),
           child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(name!,style: TextStyle(fontWeight:FontWeight.w400 ,fontSize:16.sp ,color: HexColor("#7B7B7B"),),),
              SizedBox(width: 15.w,),


            ],

          ),
        ),
      );
  }

 }
