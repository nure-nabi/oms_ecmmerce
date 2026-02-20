
class RegisterReqModel{
  String? firstName;
  String? lastName;
  String? password;
  String? phone;
  String? email;

  RegisterReqModel({required this.firstName,required this.lastName,required this.password, this.phone,required this.email});

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
   List<ValidationError>? errors;
  RegisterResModel({this.code,this.email,  this.errors,});

  Map<String,  dynamic> toJson() => {
    "code":code,
    "email":email,
  };

  factory RegisterResModel.fromJson(Map<String, dynamic> json){
    return RegisterResModel(
      code: json["code"] ?? 0,
      email: json["email"] ?? "",
        errors: json["errors"] != null
            ?
        List<ValidationError>.from(json["errors"].map((x) => ValidationError.fromJson(x)))
            : []
    );
  }

}

// Model for individual error
class ValidationError {
  final String code;
  final String message;


  ValidationError({required this.code, required this.message,});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      code: json['code'],
      message: json['message'],
    );
  }
  }