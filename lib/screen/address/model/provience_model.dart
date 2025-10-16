class ProvienceResModel {
  bool? success;
  String? message;
  List<ProvienceModel> data;

  ProvienceResModel(
      {required this.success, required this.message, required this.data});

  factory ProvienceResModel.fromJson(Map<String, dynamic> json) {
    return ProvienceResModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null
          ? List<ProvienceModel>.from(
              json["data"].map((x) => ProvienceModel.fromJson(x)))
          : [],
    );
  }
}

class ProvienceModel {
  int? id;
  String? name;
  List<CityModel>? cityies;

  ProvienceModel({ this.id,  this.name,  this.cityies});

  factory ProvienceModel.fromJson(Map<String, dynamic> json) {
    return ProvienceModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      cityies: json["cities"] != null
          ? List<CityModel>.from(
              json["cities"].map((x) => CityModel.fromJson(x)))
          : [],
    );
  }
}

class CityModel {
  int? id;
  String? name;
  List<ZoneModel> zone;
  CityModel({required this.id, required this.name,required this.zone});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] ?? 0,
      name: json["city"] ?? "",
      zone: json["zones"] != null
          ? List<ZoneModel>.from(
          json["zones"].map((x) => ZoneModel.fromJson(x)))
          : [],
    );
  }
}

class ZoneModel {
  int? id;
  String? name;

  ZoneModel({required this.id, required this.name});

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json["id"] ?? 0,
      name: json["zone_name"] ?? "",
    );
  }
}
