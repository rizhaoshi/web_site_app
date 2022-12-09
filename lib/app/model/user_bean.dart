class UserBean {
  int? userId;
  String? token;
  String? province;
  String? studyStage;
  String? gender;
  String? nickName;
  int? gaokaoYear;
  String? gaokaoCourse;
  String? gaokaoCourseIds;
  String? gaokaoCourseTypeId;
  String? gaokaoCourseType;
  int? gaokaoScore;
  String? provinceId;
  String? cityId;
  String? city;
  String? districtId;
  String? district;
  int? attentionCount;
  int? preRegistrationCount;
  int? browseArticleCount;
  String? mobile;
  String? schoolSeniorId;

  UserBean({
    this.userId,
    this.token,
    this.province,
    this.studyStage,
    this.gender,
    this.nickName,
    this.gaokaoYear,
    this.gaokaoCourse,
    this.gaokaoCourseIds,
    this.gaokaoCourseTypeId,
    this.gaokaoCourseType,
    this.gaokaoScore,
    this.provinceId,
    this.cityId,
    this.city,
    this.districtId,
    this.district,
    this.attentionCount,
    this.preRegistrationCount,
    this.browseArticleCount,
    this.mobile,
    this.schoolSeniorId,
  });

  UserBean.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'] ?? json['id'];
    province = json['province'];
    studyStage = json['studyStage'];
    gender = json['gender'];
    nickName = json['nickName'];
    gaokaoYear = json['gaokaoYear'];
    gaokaoCourse = json['gaokaoCourse'];
    gaokaoCourseIds = json['gaokaoCourseIds'];
    gaokaoCourseTypeId = json['gaokaoCourseTypeId'];
    gaokaoCourseType = json['gaokaoCourseType'];
    gaokaoScore = json['gaokaoScore'];
    provinceId = json['provinceId'];
    cityId = json['cityId'];
    city = json['city'];
    districtId = json['districtId'];
    district = json['district'];
    attentionCount = json['attentionCount'];
    preRegistrationCount = json['preRegistrationCount'];
    browseArticleCount = json['browseArticleCount'];
    mobile = json['mobile'];
    schoolSeniorId = json['schoolSeniorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    data['userId'] = userId;
    data['province'] = province;
    data['studyStage'] = studyStage;
    data['gender'] = this.gender;
    data['nickName'] = this.nickName;
    data['gaokaoYear'] = this.gaokaoYear;
    data['gaokaoCourse'] = this.gaokaoCourse;
    data['gaokaoCourseIds'] = this.gaokaoCourseIds;
    data['gaokaoCourseTypeId'] = this.gaokaoCourseTypeId;
    data['gaokaoCourseType'] = this.gaokaoCourseType;
    data['gaokaoScore'] = this.gaokaoScore;
    data['provinceId'] = this.provinceId;
    data['cityId'] = this.cityId;
    data['city'] = this.city;
    data['districtId'] = this.districtId;
    data['district'] = this.district;
    data['attentionCount'] = this.attentionCount;
    data['preRegistrationCount'] = this.preRegistrationCount;
    data['browseArticleCount'] = this.browseArticleCount;
    data['mobile'] = this.mobile;
    data['schoolSeniorId'] = schoolSeniorId;
    return data;
  }
}
