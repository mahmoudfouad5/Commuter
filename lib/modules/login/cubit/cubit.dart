 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
    // LoginModel ? loginModel ;

  bool isPasswordShow =true ;
  bool isOpen =true ;

  // void userLogin({
  //   @required String? email ,
  //   @required String? password
  // }){
  //   emit(LoginLoadingState());
  //   FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value){
  //     if(FirebaseAuth.instance.currentUser!.emailVerified){
  //       print(value.user!.email);
  //       print(value.user!.uid);
  //       emit(LoginSuccessState(value.user!.uid));
  //     }
  //     if(FirebaseAuth.instance.currentUser!.emailVerified == false){
  //       emit(LoginEmailVerifiedState());
  //     }
  //   }).catchError((error){
  //     emit(LoginErrorState(error.toString()));
  //   });
  //
  //
  // }

  IconData suffix = Icons.remove_red_eye_outlined ;

void ChangeObscuer (){
  isPasswordShow = !isPasswordShow ;
  suffix = isPasswordShow ?Icons.remove_red_eye_outlined :Icons.visibility_off ;
  emit(LoginChangeSuffixIcon());

}



  void userLogin({
    @required String? email ,
    @required String? password
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });


  }

}