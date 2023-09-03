import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo/layout/home_layout.dart';
import 'package:logo/modules/login/cubit/cubit.dart';
import 'package:logo/modules/login/cubit/states.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/network/local/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              navigatorToReplacement(context, HomeLayout());
              showToast(message: "log in Success ", state: ToastStates.SUCCESS);

            });
          }
          if (state is LoginErrorState) {


            showToast(message: state.error, state: ToastStates.ERROR);
            print(state.error);
          }

        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.topLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.0.h, left: 18.w),
                  child: Text(
                    'commuter',
                    style: TextStyle(
                      fontFamily: "Harlow",
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2631835938.h,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    opacity: .2,
                    image: AssetImage("assets/images/splash-screen.png"),
                    fit: BoxFit.cover,
                  )),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Article',
                              ),
                            ),
                            SizedBox(
                              height: 37.h,
                            ),
                            defaultTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: "البريد الالكتروني ",
                              width: MediaQuery.of(context).size.width *.8,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Email must be not Empty ";
                                }
                              },
                              prefixIcon: Icons.email_outlined,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              label: "كلمه السر ",
                              width: MediaQuery.of(context).size.width *.8,
                              isobscureText:
                                  LoginCubit.get(context).isPasswordShow,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context).ChangeObscuer();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffix)),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Password must be not Empty ";
                                }
                              },
                              prefixIcon: Icons.lock_outline_rounded,
                            ),
                            SizedBox(
                              height: 27.h,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => defaultButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  text: "دخول",
                                  fontSize: 24.sp,
                                  color: HexColor("#1F9615"),
                                  radius: 10.r,
                                  width: 100.w,
                                  height: 50.h),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
