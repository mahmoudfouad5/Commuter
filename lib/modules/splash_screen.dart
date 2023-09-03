import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logo/layout/home_layout.dart';
import 'package:logo/modules/login/login_screen.dart';
import 'package:logo/shared/componant/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if(uId !=null){
      Future.delayed(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeLayout()),
        ),
      );
    }else{
      Future.delayed(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: .46,
            image: AssetImage("assets/images/splash-screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:  Text(
            'commuter',
            style: TextStyle (
              fontFamily: "Harlow",
               fontSize: 96.sp,
              fontWeight: FontWeight.w400,
              height: 1.2631835938.h,
              fontStyle: FontStyle.italic,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}