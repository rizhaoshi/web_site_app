import 'user_bean.dart';

class LoginModel {
  String? smsCodeCallback;
  String? token;
  int? userId;
  String? nickName;
  String? province;
  String? studyStage;
  String? deviceToken;
  String? city;
  String? provinceCode;
  String? cityCode;
  int? accountId;
  UserBean? user;

  LoginModel({
    this.smsCodeCallback,
    this.token,
    this.userId,
    this.nickName,
    this.province,
    this.studyStage,
    this.deviceToken,
    this.city,
    this.provinceCode,
    this.cityCode,
    this.accountId,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    smsCodeCallback = json['smsCodeCallback'];
    token = json['token'];
    userId = json['userId'];
    nickName = json['nickName'];
    province = json['province'];
    studyStage = json['studyStage'];
    accountId = json['accountId'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['smsCodeCallback'] = smsCodeCallback;
    data['token'] = token;
    data['userId'] = userId;
    data['nickName'] = nickName;
    data['province'] = province;
    data['studyStage'] = studyStage;
    data['accountId'] = accountId;
    data['deviceToken'] = deviceToken;
    return data;
  }
}
