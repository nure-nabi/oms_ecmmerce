

class ForgetPasswordResp {
  bool success;
  String message;
  String email;
  int code;

  ForgetPasswordResp({required this.success,required this.message, required this.email,required this.code});

factory ForgetPasswordResp.fromJson(Map<String,dynamic> json){
  return ForgetPasswordResp(
  success: json['success']??false,
  message: json[''] ?? "",
  email:json['email'] ?? "",
  code:json['code'] ?? 0
 );
}
}