class CategoryTopResponse {
  bool? success;
  String? message;
  List<CategoryTopModel>? categories;

  CategoryTopResponse(
      {required this.success, required this.message, required this.categories});

  factory CategoryTopResponse.fromJson(Map<String, dynamic> json){
    return CategoryTopResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? "",
        categories: json['categories'] != null ? List<CategoryTopModel>.from(
            json['categories'].map((x) => CategoryTopModel.fromJson(x))) : []
    );
  }
}


class CategoryTopModel {

  int? id;
  int? status;
  String? category_name;
  String? image_full_url;

  CategoryTopModel(
      {required this.id, required this.status, required this.category_name, required this.image_full_url});

  factory CategoryTopModel.fromJson(Map<String, dynamic> json){
    return CategoryTopModel(
        id: json['id'] ?? 0,
        status: json['status'] ?? 0,
        category_name: json['category_name'] ?? "",
        image_full_url: json['image_full_url'] ?? "");
  }
}