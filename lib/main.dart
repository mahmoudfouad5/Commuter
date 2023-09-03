import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/layout/home_layout.dart';
import 'package:logo/modules/login/login_screen.dart';
import 'package:logo/modules/splash_screen.dart';
import 'package:logo/shared/network/local/cache_helper.dart';
import 'package:logo/tast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'shared/componant/constant.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
 import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initializeDateFormatting('ar'); // تهيئة بيانات اللغة العربية


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  uId = CacheHelper.getData(key:'uId');

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Appcubit()),
      ],
      child: BlocConsumer<Appcubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: HexColor("#FFD700"),

              /* dark theme settings */
            ),
            themeMode: ThemeMode.dark,
            home: ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (context, child) {
                return SplashScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
