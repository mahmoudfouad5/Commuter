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
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {},
    onEnded: () => print('onEnded'),
  );

  bool isgo = false ;

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

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
                                "التسجيل",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.timer,
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
                   ],
                ),
              ),
              SizedBox(height: 50.h,),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value ?? 0,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displaysecond = StopWatchTimer.getDisplayTime(
                    value!,
                    hours: false,
                    milliSecond: false,
                    second: true,
                    minute: false,

                  );
                  final displayminute= StopWatchTimer.getDisplayTime(
                    value,
                    minute: true,
                    milliSecond: false,
                    hours: false,
                    second: false,

                  );
                  final displayhours= StopWatchTimer.getDisplayTime(
                    value,
                    minute: false,
                    milliSecond: false,
                    hours: true,
                    second: false,

                  );

                  return  buildTimeritem(minute:displayminute,hours: displayhours ,second: displaysecond)
                  ;
                },
              ),

              SizedBox(height: 16.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(

                    child: Text(isgo ?  'Stop': 'Start'  ),
                    onPressed: () {
                       isgo = !isgo;
                      setState(() {

                      });
                      if (_stopWatchTimer.isRunning) {
                        _stopWatchTimer.onStopTimer();
                      } else {
                        _stopWatchTimer.onStartTimer();
                      }
                    },
                  ),
                  SizedBox(width: 16.0),
                  // ElevatedButton(
                  //   child: Text('Reset'),
                  //   onPressed: () {
                  //     _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  //   },
                  // ),
                ],
              ),



            ],
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }

 Widget buildTimeritem({@required String? hours,@required String? minute,@required String? second, }){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            color: HexColor("#464242"),
            borderRadius: BorderRadius.circular(
              10.r

                 ),
          ),
          width:68.w ,
          height:70.h ,
          child: Center(
            child: Text(
               hours!,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w400)
            ),
          ),
        ),
        SizedBox(width: 15.w,),
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
            color: HexColor("#464242"),
            borderRadius: BorderRadius.circular(
                10.r

            ),
          ),
          width:68.w ,
          height:70.h ,
          child: Center(
            child: Text(
                minute!,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(width: 15.w,),
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
            color: HexColor("#464242"),
            borderRadius: BorderRadius.circular(
                10.r

            ),
          ),
          width:68.w ,
          height:70.h ,
          child: Center(
            child: Text(
                second!,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w400)
            ),
          ),
        ),

      ],
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
                  "Timer",
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
