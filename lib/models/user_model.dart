
class UserData{

  String? name;
  String? profileImage;
  String? email;
  String? phone;
  String? password;
  String? uId;
  bool? isAdmin;
   UserData({
    this.email,
    this.profileImage,
   this.name,
   this.phone,
   this.password,
   this.uId,
   this.isAdmin,
  });
 UserData.fromJson(Map<String,dynamic>json)
 {
   email=json['email'];
   profileImage=json['profileImage'];
   name=json['name'];
   phone=json['phone'];
   password=json['password'];
   uId=json['uId'];
   isAdmin=json['isAdmin'];
    }
 Map<String,dynamic>toMap(){
   return
       {
         'name':name,
         'profileImage':profileImage,
         'email':email,
         'phone':phone,
         'password':password,
         'uId':uId,
         'isAdmin':isAdmin,
         };

 }
}