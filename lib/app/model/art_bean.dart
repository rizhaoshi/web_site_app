import 'user_bean.dart';

class ArtBean {
  String? artTitle;
  String? artInfo;

  UserBean? userBean;

  ArtBean({
    this.artTitle,
    this.artInfo,
  });

  ArtBean.fromJson(Map<String, dynamic> json) {
    artTitle = json['artTitle'];
    artInfo = json['artInfo'];
    if (json['user'] != null) {
      userBean = UserBean.fromJson(json['user']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['artTitle'] = artTitle;
    data['artInfo'] = artInfo;

    return data;
  }
}
