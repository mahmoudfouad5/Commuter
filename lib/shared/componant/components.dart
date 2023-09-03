 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:hexcolor/hexcolor.dart';

Widget  defaultButton({
  double? width    ,
  double? height,
  double? fontSize,
  Color ? color ,
   Color textColor = Colors.white,
  @required VoidCallback? onPressed,
  bool isUpperCase = true,
  @required String? text,
  double radius = 5.0,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      width: width,
      height: height,
      child: Center(
        child: MaterialButton(
          onPressed: onPressed,
          child: Center(
            child: Text(


              text!,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w400
              ),

            ),
          ),
        ),
      ),
    );

 Widget  defaultTextFormField({
   @required TextEditingController? controller,
   ValueChanged<String>? onChanged,
   ValueChanged<String>? onFieldSubmitted,
   GestureTapCallback? onTap,
   TextInputType? keyboardType,
   @required String? label ,
    IconData? prefixIcon,
   Widget? suffixIcon,
   double reduis = 5,
   @required double? width  ,
   @required double? height  ,
   int? lim ,
   @required FormFieldValidator<String>? validate,
   bool isobscureText = false,
   VoidCallback? suffixPressed,
 }) =>
     SizedBox(
       height: height,
       width: width,
        child: Directionality(
         textDirection: TextDirection.rtl,
         child: Container(
           decoration: BoxDecoration(
               color: HexColor("#ECECEC"),
               borderRadius: BorderRadius.circular(10.r)),
           child: TextFormField(
             obscureText: isobscureText,
             controller: controller,
             onFieldSubmitted: onFieldSubmitted,
             onChanged: onChanged,
             onTap: onTap,
             keyboardType: keyboardType,
             validator: validate,
             style: TextStyle(color: Colors.black),
             decoration: InputDecoration(

               suffixIcon: suffixIcon,
                 prefixIcon: Padding(
                   padding:   EdgeInsets.only(bottom: 0.0.h),
                   child: Icon(prefixIcon,color: Colors.grey[700],size: 40.h,),
                 ),
                  hintText: label,
                 hintStyle: TextStyle(

                     fontWeight: FontWeight.w400,

                     color: Colors.grey[700], fontSize: 20.sp),
                 border: InputBorder.none),
           ),
         ),
       ),
     );



void navigatorTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget ) );

void navigatorToReplacement(context, Widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Widget));
 void showToast({
   @required String? message,
   @required ToastStates? state,
 }) =>
     Fluttertoast.showToast(
         msg: message!,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 3,
         backgroundColor: chooseToastColor(state!),
         textColor: Colors.white,
         fontSize: 16.0.sp);

 enum ToastStates { SUCCESS, ERROR, WARNING }

 Color? chooseToastColor(ToastStates state) {
   Color color;
   switch (state) {
     case ToastStates.SUCCESS:
       color = Colors.green;
       break;
     case ToastStates.ERROR:
       color = Colors.red;
       break;
     case ToastStates.WARNING:
       color = Colors.amber;
       break;
   }
   return color;
 }






