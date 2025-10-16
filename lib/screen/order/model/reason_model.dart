class ReasonResponse {
  bool? success;
  String? message;
  List<ReasonModel> reasons;

  ReasonResponse({required this.success, required this.message,required this.reasons});

  factory ReasonResponse.fromJson(Map<String, dynamic> json){
    return ReasonResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      reasons: json["reasons"] != null ? List<ReasonModel>.from(json['reasons'].map((x)=>ReasonModel.fromJson(x))) : []
    );
  }
}

class ReasonModel {
  int? id;
  String? reason_name;
  String? reason_for;
  int? status;

  ReasonModel(
      {required this.id, required this.reason_name, required this.reason_for, required this.status});

  factory ReasonModel.fromJson(Map<String, dynamic> json){
    return ReasonModel(
        id: json["id"] ?? 0,
        reason_name: json["reason_name"] ?? "",
        reason_for: json["reason_for"] ?? "",
        status: json["status"] ?? 0
    );
  }
}

