
class LoginReqModel {
  late final String? email;
  late final String? password;


  LoginReqModel({ this.email, this.password});

 factory LoginReqModel.fromJson(Map<String, dynamic> json) {
    return LoginReqModel(
        email: json["email"],
        password: json["password"],

    );
  }

  //  LoginReqModel.fromJson(Map<String, dynamic> json) {
  //    email = json["email"];
  //    password = json["password"];
  // }

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };

}



class UserModel {
  late final int? id;
  late final String? name;
  late final String? email;

  UserModel({this.id,this.name,this.email});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",

    );
  }
}

class LoginRespModel {
  late final bool? success;
  late final String? message;
  late final String? token;
  UserModel? user;
  LoginRespModel({this.success,this.message,this.token,this.user});


  factory LoginRespModel.fromJson(Map<String, dynamic> json) {
    return LoginRespModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data["success"] = this.success;
    data["message"] = this.message;
    return data;
  }
}




