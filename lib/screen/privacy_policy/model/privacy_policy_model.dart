class PrivacyPolicyRes{

  List<PrivacyPolicyModel> privacyPolicy;
  PrivacyPolicyRes({required this.privacyPolicy});

  factory PrivacyPolicyRes.fromJson(Map<String, dynamic> json){
    return PrivacyPolicyRes(
        privacyPolicy: json["compliances"] != null ? List<PrivacyPolicyModel>.from(json["compliances"].map((x)=> PrivacyPolicyModel.fromJson(x))) : []
    );
  }
}

class PrivacyPolicyModel{
   int? id;
   String? key;
   String? value;
   List<ComplianceFilesModel> fileList;

   PrivacyPolicyModel({required this.id,required this.key,required this.value,required this.fileList});

   factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json){
     return PrivacyPolicyModel(
         id: json["id"] ?? 0,
         key: json["key"] ?? "",
         value: json["value"] ?? "",
         fileList: json["compliancefiles"] != null ? List<ComplianceFilesModel>.from(json["compliancefiles"].map((x)=> ComplianceFilesModel.fromJson(x))) : []

     );
   }
}

class ComplianceFilesModel{
  String? title;
  String? file_url;

  ComplianceFilesModel({required this.title,required this.file_url});

  factory ComplianceFilesModel.fromJson(Map<String, dynamic> json){
    return ComplianceFilesModel(
        title: json["title"] ?? "",
        file_url: json["file_url"] ?? "",
    );
  }
}