
class RegisterReqModel{
  String? firstName;
  String? lastName;
  String? password;
  String? phone;
  String? email;

  RegisterReqModel({required this.firstName,required this.lastName,required this.password,required this.phone,required this.email});

  Map<String, dynamic> toJson() => {
    "first_name":firstName,
    "last_name":lastName,
    "password":password,
    "phone":phone,
    "email":email,
  };

  factory RegisterReqModel.fromJson(Map<String, dynamic> json){

    return RegisterReqModel(
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? ""
    );
    }

}

class RegisterResModel{
  int? code;
  String? email;
  RegisterResModel({this.code,this.email});

  Map<String,  dynamic> toJson() => {
    "code":code,
    "email":email,
  };

  factory RegisterResModel.fromJson(Map<String, dynamic> json){
    return RegisterResModel(
      code: json["code"] ?? 0,
      email: json["email"] ?? "",
    );
  }

}