class AppVersionBean {
  bool? isNeed;
  String? isForce;
  String? updateContent;
  String? packageUrl;

  AppVersionBean.fromJson(Map<String, dynamic> json) {
    isNeed = json['isNeed'];
    isForce = json['isForce'];
    updateContent = json['updateContent'];
    packageUrl = json['packageUrl'];
  }
}
