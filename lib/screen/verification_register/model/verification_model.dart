class VerificationReqModel{
  String? verificationCode;
  String? email;
  VerificationReqModel({required this.verificationCode,required this.email});

  Map<String, dynamic> toJson() =>{
    "user_verification_code": verificationCode,
    "email":email
  };
}

class VerificationResModel{
  bool? success;
  String? message;
  VerificationResModel({required this.success,required this.message});

  factory VerificationResModel.fromJson(Map<String, dynamic> json){
    return VerificationResModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "");
  }

  Map<String, dynamic> toJson() =>{
    "success": success,
    "message":message
  };
}