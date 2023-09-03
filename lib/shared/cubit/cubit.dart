import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logo/layout/home_layout.dart';
import 'package:logo/models/driver_shifts_model.dart';
 import 'package:logo/models/message_model.dart';
import 'package:logo/models/message_to_model.dart';
 import 'package:logo/modules/driver_shifts.dart';
import 'package:logo/modules/faq.dart';
import 'package:logo/modules/login/login_screen.dart';
import 'package:logo/modules/reports.dart';
import 'package:logo/modules/sessions_screen.dart';
import 'package:logo/modules/soon.dart';
import 'package:logo/modules/user_screen.dart';

import 'package:logo/shared/cubit/states.dart';

import '../../models/messages_model.dart';
import '../componant/constant.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());

  static Appcubit get(context) => BlocProvider.of(context);

  List<String> nameInst = [
    "حزام الأمان ",
    "السرعات ",
    "الركاب",
    "السيارة",
    "الدورات",
    "تعليمات عامة",
  ];
  List<String> iconPathInst = [
    "assets/icons/home/Passenger.png",
    "assets/icons/home/Fast Download.png",
    "assets/icons/home/Protection Mask (1).png",
    "assets/icons/home/Hennessey Venom (1).png",
    "assets/icons/home/Journey.png",
    "assets/icons/home/User Manual.png",
  ];

  List<String> nameDrawer = [
    "المستخدم",
    "الصفحة الرئيسية",
    "وردية جديدة",
    "الخريطه",
    "الدورات",
    "التقارير ",
    "المساعدة ",
    "FAQ",
   ];
  List<String> iconPathDrawer = [
    "assets/icons/home/user-hRP.png",
    "assets/icons/home/Home.png",
    "assets/icons/home/car.png",
    "assets/icons/home/Google Maps Old.png",
    "assets/icons/home/Planned Path.png",
    "assets/icons/home/Terms and Conditions.png",
    "assets/icons/home/Services.png",
    "assets/icons/home/Questions.png",
   ];
  List<String> iconPathUser = [
    "assets/icons/Male User.png",
    "assets/icons/Alarm.png",
    "assets/icons/Services (1).png",
  ];
  List<String> nameUser = ["بيانات المستخدم ", "الاشعارات ", "المساعدة"];
  List<String> iconPath = [
    "assets/icons/driver/Hennessey Venom.png",
    "assets/icons/driver/Speedometer.png",
    "assets/icons/driver/Request Money.png",
    "assets/icons/driver/Initiate Money Transfer.png",
    "assets/icons/driver/Supply Chain.png",
    "assets/icons/driver/Speedometer.png",
    "assets/icons/driver/Page.png",
  ];

  List<String> titel = [
    "نوع السيارة",
    "قرائة العداد (بداية)",
    "إيراد",
    "مصروفات",
    "التوريد",
    "قرائة العداد (نهاية)",
    "ملاحظات",
  ];

  List<String> drTitles = [
    "ساعات العمل",
    "إجمالي العهدة",
    "عدد الرحلات",
    "بنزين",
    "كيلومترات",
    "غاز",
    "ايراد التطبيقات",
    "شحن التطبيقات",
    "ايراد التوصيلات الخارجى ",
    "مصروفات اضافة ",
    "ايراد الدورات",
    "اجمالى مصروفات اليوم",
    "رصيد التوصيلات الخارجية ",
    "الغرامة",
    "اجمالى ايراد اليوم ",
    "توريد النقدى ",
    "اجمالى الايراد",
    "اجمالي التوريدات",
    "عهدة اليوم",

  ];

  List<String> drResult = [
    "9",
    "",
    "8",
    "",
    "190",
    "",
    "500",
    "",
    "300",
    "",
    "400",
    "",
    "30",
    "",
    "1200",
    "",
    "1200",

  ];


  List<String> moTitles = [
    "رحلات",
    "بنزين + غاز",
    "ايراد",
    "مصروفات اخري",
    "عدد ساعات العمل",
    "متوسط مسافة الرحلة",
    "متوسط قيمة الرحلة",
    "متوسط قيمةالكيلومترات",
    "متوسط قيمةالساعة",
    "التوريدات",
    " متوسط الربح اليومى ",
    "عهدة الكابتن",
    " اجمالى اجر الكابتن ",
    "اجمالى التوريدات",
    "اجمالى الربح ",
    " متوسط الاجر اليومى ",
    "السيارة"

  ];

  List<String> moResult = [
    "9",
    "",
    "8",
    "",
    "190",
    "",
    "500",
    "",
    "300",
    "",
    "400",
    "",
    "30",
    "",
    "1200",
    "",
    "1200",

  ];

  String isnull = "";


  List<String> faq = [
    "السؤال 1",
    "السؤال 2",
    "السؤال 3",
    "السؤال 4",
    "تم جميع الاسالة",
   ];



  void MessagesAllCreate({
    @required String? name,
    @required String? nameday,
   }) {
    MessagesModel  messagesWithDate = MessagesModel(
      name: name,
      timestamp:  Timestamp.now(),
      nameday: nameday,


    );

    emit(CreateMessageAllLoadingState());

    FirebaseFirestore.instance
        .collection('messagesWith').doc(name)
        .set(messagesWithDate.toMap())
        .then((value) {
      String? Successmassege = "messages Added";

      emit(CreateMessageAllSuccessState(Successmassege));
    }).catchError((error) {
      print(error.toString());


      emit(CreateMessageAllErrorState(error.toString()));
    });
  }


  void MessageAllCreate({
    @required String? name,
    @required String? dataname,
    @required String? time,
    @required String? addby,
    @required String? nameday,
    @required String? path,
    @required Map<String, dynamic>? isread,
   }) {
    MessageModel  messagesWithDate = MessageModel(
      name: name,

      timestamp:  Timestamp.now(),
      nameday: nameday,
      addby: addby,
      time: time,
      map1: isread,
      dataname: dataname,





    );

    emit(CreateMessageAllLoadingState());

    FirebaseFirestore.instance
        .collection('messagesWith/${path}/${path}')
        .add(messagesWithDate.toMap())
        .then((value) {
      String? Successmassege = "messages Added";

      emit(CreateMessageAllSuccessState(Successmassege));
    }).catchError((error) {
      print(error.toString());
      emit(CreateMessageAllErrorState(error.toString()));
    });
  }

  void MessagesToCreate({
    @required String? name,
    @required String? nameday,
  }) {
    MessagesModel  messagesToDate = MessagesModel(
      name: name,
      timestamp:  Timestamp.now(),
      nameday: nameday,


    );

    emit(CreateMessageToLoadingState());

    FirebaseFirestore.instance
        .collection('messagesTo').doc(name)
        .set(messagesToDate.toMap())
        .then((value) {
      String? Successmassege = "messages Added";

      emit(CreateMessageToSuccessState(Successmassege));
    }).catchError((error) {
      print(error.toString());


      emit(CreateMessageToErrorState(error.toString()));
    });
  }

  void MessagetoCreate({
    @required String? name,
    @required String? dataname,
    @required String? time,
    @required String? addby,
    @required String? to,
    @required String? nameday,
    @required String? path,
     @required   Map<String, dynamic>? isread,
  }) {
    MessageToModel  messagesTO = MessageToModel(
      name: name,
      timestamp:  Timestamp.now(),
      nameday: nameday,
      addby: addby,
      time: time,
      map1: isread,
      dataname: dataname,
      to: to

    );

    emit(CreateMessagesToLoadingState());

    FirebaseFirestore.instance
        .collection('messagesTo/${path}/${path}')
        .add(messagesTO.toMap())
        .then((value) {
      String? Successmassege = "messages Added";

      emit(CreateMessagesToSuccessState(Successmassege));
    }).catchError((error) {
      print(error.toString());
      emit(CreateMessagesToErrorState(error.toString()));
    });
  }

  void updateMapValue(String path, String id, String uId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('messagesWith/${path}/${path}').doc(id);
    DocumentSnapshot doc = await docRef.get();
    Map<String, dynamic> currentData = doc.data() as Map<String, dynamic>;
    currentData['map1'][uId] = true;
    docRef.update(currentData);
  }




  List<MessagesModel> messagesModel = [];

  void getMessagesData({@required String? path   }) {
    emit(GetMessagesAllLoadingState());

    FirebaseFirestore.instance.collection('messagesWith').orderBy('timestamp', descending: true).limit(7).get()
        .then((value) {
      messagesModel = [];
      value.docs.forEach((element) {
        messagesModel.add(MessagesModel.fromJson(element.data()));
      });

      emit(GetMessagesAllSuccessState());
    }).catchError((error) {
      emit(GetMessagesAllErrorState(error.toString()));
      print(error.toString());
    });
  }





  List<String> stringsList = [];

  Future<List<String>> getListOfStrings() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('carType').get();

    querySnapshot.docs.forEach((document) {
      List<dynamic> strings = document.data()['a'];

      for (int i = 0; i < strings.length; i++) {
        stringsList.add(strings[i].toString());
      }
    });

    return stringsList;
  }





  List<bool> isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

   final streamController = StreamController();






  List<Widget> screens = [
    UserScreen(),
    HomeLayout(),
    DriverShifts(),
    Soon(),
    SessionsScreen(),
    Reports(),
    Soon(),
    FAQ(),
   ];

  final imagepicker = ImagePicker();
  File? image;
  UploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      emit(pickedImageSuccessfulState());
      image = File(pickedImage.path);
    }
  }



  void ShiftsData({
    @required String? car_Type,
    @required int? no_start,
    @required List<dynamic>? app_charge,
    @required List<dynamic>? app_income,
    @required String? day_data,
    @required String? addby,
    @required String? end_path,
    @required List<dynamic>? exp_gas,
    @required List<dynamic>? exp_petrol,
    @required List<dynamic>? more_outcome,
    @required int? no_end,
    @required String? notes,
    @required List<dynamic>? out_income,
    @required String? start_path,
    @required List<dynamic>? supplies,
    @required int? total_time,
     }) {
    ShiftsDataModel  shiftsDataModel = ShiftsDataModel(
      car_Type:car_Type ,
      no_start:no_start ,
      app_charge:app_charge ,
      app_income: app_income,
      day_data:day_data ,
       end_path:end_path ,
      exp_gas:exp_gas ,
      exp_petrol:exp_petrol ,
      more_outcome:more_outcome ,
      no_end:no_end ,
      notes:notes ,
      out_income:out_income ,
      start_path:start_path ,
      supplies:supplies ,
      total_time:total_time ,
      timestamp:Timestamp.now() ,
      uId:uId ,


    );

    emit(CreateShiftsDataLoadingState());

    FirebaseFirestore.instance
        .collection('ShiftsData')
        .add(shiftsDataModel.toMap())
        .then((value) {
      String? Successmassege = "messages Added";

      emit(CreateShiftsDataSuccessState(Successmassege));
    }).catchError((error) {
      print(error.toString());
      emit(CreateShiftsDataErrorState(error.toString()));
    });
  }


  Future<List<String>> uploadImagesToFirebase(List<File> images) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      File image = images[i];

      // Create a reference to the Firebase Storage path where the image will be uploaded
      Reference storageReference =
      FirebaseStorage.instance.ref().child("images/image$i.jpg");

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;

      // Get the download URL of the uploaded image
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }




// CollectionReference messages =
  // FirebaseFirestore.instance.collection("users");
  // List<MessagesModel> messagesList = [];
  //
  // Widget MessagesAll(){
  //   return StreamBuilder(
  //     stream: collectionStream,
  //     builder: (context, snapshot) {
  //       if(snapshot.hasError){
  //         return Text("error") ;
  //       }
  //       if(snapshot.connectionState == ConnectionState.waiting){
  //         return Text("Loading....");
  //       }
  //       if(snapshot.hasData){
  //         messagesList = [] ;
  //         snapshot.data!.docs.forEach((element) {
  //           messagesList.add(MessagesModel.fromJson(element.data()));
  //
  //
  //         });
  //         return ListView.builder(
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 Text("${snapshot.data!.docs[index].data()['text'] }"),
  //                 TextButton(
  //                     onPressed: () {
  //
  //                       FirebaseFirestore.instance.collection('users').add({
  //                         'text': 'Hello11',
  //                         'msn': FieldValue.serverTimestamp(),
  //                       });
  //
  //                     },
  //                     child: Text("mahmoud"))
  //               ],
  //             );
  //           },
  //           itemCount: snapshot.data!.docs.length,
  //         );
  //       }
  //       return Text("mahmoud");
  //     }
  //     ,
  //   ) ;
  // }




// var user;
//
// void getUserdata() {
//   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
//     print(value.data());
//     user = value;
//
//     model = UserData.fromJson(value.data()!);
//     emit(GetUserDataSuccessState());
//   }).catchError((error) {
//     print(error.toString());
//     emit(GetUserDataErrorState(error.toString()));
//   });
// }

/////////////////////////////////////////

// void userRegister({
//   @required String? email ,
//   @required String? password,
//   @required String? name,
//   @required String? phone,
//   @required bool? isAdmin,
//   @required bool? isHti,
//   @required String? profileImage,
//   @required bool? isVerified,
//
// }){
//   emit(RegisterLoadingState());
//
//   FirebaseAuth.instance.
//   createUserWithEmailAndPassword(
//     email: email!,
//     password: password!,
//
//   )
//       .then((value) {
//     emit(RegisterSuccessState());
//     userCreate(email: email,
//         password: password,
//         name: name,
//         phone: phone,
//         isAdmin: isAdmin,
//         isHti: isHti,
//         isVerified:isVerified ,
//         profileImage:profileImage ,
//         uId: value.user!.uid
//     );
//
//   }).catchError((error){
//
//     emit(RegisterErrorState(error.toString()));
//   });
//
//
//
// }
//
// UserData model =UserData();
// void userCreate({
//   @required String? email ,
//   @required String? profileImage ,
//   @required String? password,
//   @required String? name,
//   @required String? phone,
//   @required String? uId,
//   @required bool? isVerified,
//   @required bool? isAdmin,
//   @required bool? isHti,
//
// }){
//   UserData model =UserData(
//     name: name,
//     profileImage: profileImage,
//     phone: phone,
//     password: password,
//     email: email,
//     uId: uId,
//     isVerified:isVerified,
//     isAdmin:isAdmin,
//     isHti:isHti,
//   );
//   FirebaseFirestore.
//   instance.
//   collection('users')
//       .doc(uId).set(
//       model.toMap()).then((value){
//     emit(CreateUserSuccessState(uId));
//   }).catchError((error)
//   {
//     print(error.toString());
//     emit(CreateUserErrorState(error.toString()));
//   }
//
//   );
//
//
//
// }

/////////////////////////////////////////////////////////////

//
// void uploadProfileImage({
//   @required String? dataTime,
// }) {
//   emit(CreateUserprofileImageLoadingState());
//
//   firebase_storage.FirebaseStorage.instance
//       .ref()
//       .child(
//       'users/profileImage/${uId}/${Uri.file(profileImage!.path).pathSegments.last}')
//       .putFile(profileImage!)
//       .then((value) {
//     value.ref.getDownloadURL().then((value) {
//       value =profileImagepath!;
//
//       createNewImageProfile(
//         postImage: value,
//         dataTime: dataTime,
//
//       );
//       getProfileImage();
//     }).catchError((error) {
//       emit(CreateUserprofileImageErrorState(error));
//     });
//   }).catchError((error) {
//     emit(CreateUserprofileImageErrorState(error));
//   });
// }
//
// void createNewImageProfile({
//   @required String? dataTime,
//   @required String? postImage,
// }) {
//   PostModel postModel = PostModel(
//     uId: uId,
//     dataTime: dataTime,
//     postImage: postImage,
//
//   );
//
//   emit(CreateUserprofileImageLoadingState());
//
//   FirebaseFirestore.instance
//       .collection('usersImageNote/${uId}/profileImage')
//       .add(postModel.toMap())
//       .then((value) {
//     String? Successmassege = "profileImage is Added";
//
//     emit(CreateUserprofileImageSuccessState(Successmassege));
//   }).catchError((error) {
//     print(error.toString());
//     emit(CreateUserprofileImageErrorState(error.toString()));
//   });
// }
//
//
// void getProfileImage() {
//   emit(GetprofileImageLoadingState());
//
//   FirebaseFirestore.instance
//       .collection("usersImageNote/${uId}/profileImage")
//       .get()
//       .then((value) {
//
//     emit(GetprofileImageSuccessState());
//   }).catchError((error) {
//     emit(GetprofileImageErrorState(error.toString()));
//   });
// }
}
