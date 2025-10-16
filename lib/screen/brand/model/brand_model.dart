class BrandResponse {
  bool? success;
  String? message;
  List<BrandModel>? brands;

  BrandResponse(
      {required this.success, required this.message, required this.brands});

  factory BrandResponse.fromJson(Map<String, dynamic> json){
    return BrandResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? "",
        brands: json['brands'] != null ? List<BrandModel>.from(json['brands'].map((x)=> BrandModel.fromJson(x))) : []
    );
  }
}

class BrandModel {
  int? id;
  String? brand_name;
  String? image_full_url;
  int? top;
  int? status;

  BrandModel(
      {required this.id, required this.brand_name,required this.image_full_url, required this.top, required this.status});

  factory BrandModel.fromJson(Map<String, dynamic> json){
    return BrandModel(
        id: json['id'] ?? 0,
        brand_name: json['brand_name'] ?? "",
        image_full_url: json['image_full_url'] ?? "",
        top: json['top'] ?? 0,
        status: json['status'] ?? 0);
  }
}