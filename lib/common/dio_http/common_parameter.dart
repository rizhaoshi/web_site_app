import '../storage/storage_constant.dart';
import '../storage/storage_util.dart';
import '../utils/object_util.dart';

class CommonParameter {
  static final CommonParameter _instance = CommonParameter._internal();

  // 私有的命名构造函数
  CommonParameter._internal();

  static CommonParameter get instance => _instance;

  static Future<CommonParameter> getInstance() async {
    if (ObjectUtil.isEmptyString(_instance.accessToken)) {
      instance.accessToken = (await StorageUtil.instance.getString(StorageConstant.TOKEN))!;
    }
    if (ObjectUtil.isEmptyString(_instance.deviceToken)) {
      _instance.deviceToken = (await StorageUtil.instance.get(StorageConstant.DEVICE_TOKEN))!;
    }
    return _instance;
  }

  String partner = "android";

  CommonParameter({
    required this.partner,
    required this.partnerVersion,
    required this.partnerChannel,
    required this.accessToken,
    required this.deviceToken,
  });

  String partnerVersion = "10.0.2";
  String partnerChannel = "huawei";
  String accessToken = "";
  String deviceToken = "";

  factory CommonParameter.fromJson(dynamic item) {
    return CommonParameter(
      partner: item['partner'],
      accessToken: item['accessToken'],
      partnerVersion: item['partnerVersion'],
      partnerChannel: item['partnerChannel'],
      deviceToken: item['deviceToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        "partner": partner,
        "partnerVersion": partnerVersion,
        "partnerChannel": partnerChannel,
        "accessToken": accessToken,
        "deviceToken": deviceToken,
      };

  static setDeviceToken(String deviceToken) {
    _instance.deviceToken = deviceToken;
  }

  static setAccessToken(String accessToken) {
    _instance.accessToken = accessToken;
  }
}
