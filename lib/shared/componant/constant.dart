

 import 'package:logo/modules/login/login_screen.dart';
import 'package:logo/shared/componant/components.dart';
import 'package:logo/shared/network/local/cache_helper.dart';

void singOut(context){
  CacheHelper.removeData(key: "uId").then((value){
    if(value!){
      navigatorToReplacement(context,  LoginScreen());


    }
  }) ;

}
String ? uId = CacheHelper.getData(key: "uId") ;


const KMessage = 'message' ;