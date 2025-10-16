// "categories": [
// {
// "id": 1,
// "category_name": "category 1",
// "image": "2025-05-01-68134ec252d23.png",
// "status": 1,
// "created_at": "2025-05-01T10:08:44.000000Z",
// "updated_at": "2025-05-01T10:36:50.000000Z",
// "image_full_url"

class CategoryResModel{
  List<CategoryModel> categoriesList;
  CategoryResModel({required this.categoriesList});

  factory CategoryResModel.fromJson(Map<String,dynamic> json){
    return CategoryResModel(
      categoriesList: json["categories"] != null
          ? List<CategoryModel>.from(
          json["categories"].map((x) => CategoryModel.fromJson(x)))
          : [],
    );
  }
}

class CategoryModel{
  String? categoryName;
  int? id;
  int? status;
  String? imageFullUrl;
  List<ActiveChildrenModel>? activeChildren;

  CategoryModel({required this.categoryName,required this.id, required this.status, required this.imageFullUrl,this.activeChildren});

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
        categoryName: json["category_name"] ?? "",
        id: json["id"] ?? 0,
        status: json["status"] ?? 0,
        imageFullUrl: json["image_full_url"] ?? "",
      activeChildren: json["active_children"] != null
          ? List<ActiveChildrenModel>.from(
          json["active_children"].map((x) => ActiveChildrenModel.fromJson(x)))
          : [],
    );
  }
}

class ActiveChildrenModel{
  String? categoryName;
  int? id;
  int? status;
  String? imageFullUrl;
  List<ActiveChildrenModel2>? activeChildren2;
  ActiveChildrenModel({required this.categoryName,required this.id, required this.status, required this.imageFullUrl,this.activeChildren2});

  factory ActiveChildrenModel.fromJson(Map<String,dynamic> json){
    return ActiveChildrenModel(
      categoryName: json["category_name"] ?? "",
      id: json["id"] ?? 0,
      status: json["status"] ?? 0,
      imageFullUrl: json["image_full_url"] ?? "",
      activeChildren2: json["active_children"] != null
          ? List<ActiveChildrenModel2>.from(
          json["active_children"].map((x) => ActiveChildrenModel2.fromJson(x)))
          : [],
    );
  }

}

class ActiveChildrenModel2{
  String? categoryName;
  int? id;
  int? status;
  String? imageFullUrl;
  List<ActiveChildrenModel3>? activeChildren3;
  ActiveChildrenModel2({required this.categoryName,required this.id, required this.status, required this.imageFullUrl,this.activeChildren3});

  factory ActiveChildrenModel2.fromJson(Map<String,dynamic> json){
    return ActiveChildrenModel2(
      categoryName: json["category_name"] ?? "",
      id: json["id"] ?? 0,
      status: json["status"] ?? 0,
      imageFullUrl: json["image_full_url"] ?? "",
      activeChildren3: json["active_children"] != null
          ? List<ActiveChildrenModel3>.from(
          json["active_children"].map((x) => ActiveChildrenModel3.fromJson(x)))
          : [],
    );
  }

}

class ActiveChildrenModel3{
  String? categoryName;
  int? id;
  int? status;
  String? imageFullUrl;

  ActiveChildrenModel3({required this.categoryName,required this.id, required this.status, required this.imageFullUrl});

  factory ActiveChildrenModel3.fromJson(Map<String,dynamic> json){
    return ActiveChildrenModel3(
      categoryName: json["category_name"] ?? "",
      id: json["id"] ?? 0,
      status: json["status"] ?? 0,
      imageFullUrl: json["image_full_url"] ?? "",
    );
  }

}