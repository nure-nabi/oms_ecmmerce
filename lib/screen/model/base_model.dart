class BaseModel{
  bool? success;
  String? message;
  BaseModel({required this.success, required this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json){
    return BaseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "");
  }
}