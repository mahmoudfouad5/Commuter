
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logo/shared/componant/components.dart';

class Soon extends StatelessWidget {
  const Soon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 78.0.w),
              child: Image.asset("assets/images/coming-soon.png")
              // Text("Coming Soon ....",style: TextStyle(color: Colors.black,fontSize: 60),),
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 75.0.w),
              child: defaultButton(onPressed: (){
                Navigator.pop(context);
              }, text: "Back",
                  radius: 20.r,

              fontSize: 30.sp,
                color: Colors.teal
              ),
            )
          ],
        ),
      ),
    );
  }
}
