class BasicModel{
  bool? success;
  String? message;
  List<ErrorsModel>? errors;

  BasicModel({required this.success, required this.message,this.errors});



  factory BasicModel.fromJson(Map<String, dynamic> json){
    return BasicModel(
        success: json['success'] ?? false,
        message: json['message'] ?? "",
        errors: json['errors'] != null ? List<ErrorsModel>.from(json['errors'].map((x)=>ErrorsModel.fromJson(x))) : [],
    );
  }
}

class ErrorsModel{
  String code;
  String message;
  ErrorsModel({required this.code,required this.message});

  factory ErrorsModel.fromJson(Map<String,dynamic> json){
    return ErrorsModel(code: json['code'] ?? "", message:  json['message'] ?? "");
  }
}