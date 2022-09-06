import 'dart:convert';

class Usermodel{
  
  Usermodel({
    required this.id,
    required this.fullname,
    required this.lastname,
    required this.email,
    required this.email_verified_at,
    required this.password,
    required this.tel,
    required this.role,
    required this.remember_token,
    required this.created_at,
    required this.updated_at,

  });
  late String id;
  late String fullname;
  late String lastname;
  late String email;
  late String email_verified_at;
  late String password;
  late String tel;
  late String role;
  late String remember_token;
  late String created_at;
  late String updated_at;



  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    id: json["id"],
     fullname: json["fullname"],
      lastname: json["lastname"],
       email: json["email"],
        email_verified_at: json["email_verified_at"],
         password: json["password"],
          tel: json["tel"],
           role: json["role"],
           remember_token: json["remember_token"],
            created_at: json["created_at"],
             updated_at: json["updated_at"]);

}