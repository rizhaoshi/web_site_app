import 'dart:convert';
import '../../app/model/login_model.dart';
import '../../app/model/user_bean.dart';
import '../storage/storage_constant.dart';
import '../storage/storage_util.dart';
import 'log_util.dart';
import 'object_util.dart';

class LoginUtil {
  static final LoginUtil instance = LoginUtil();
  late LoginModel mLoginModel;

  static LoginUtil getInstance() {
    return instance;
  }

  /*
   * 登录成功后保存一些常用的用户信息
   */
  static void setLoginInfo(LoginModel loginModel) {
    instance.mLoginModel = loginModel;
    StorageUtil.instance.putBool(StorageConstant.IS_LOGIN, true);
    // StorageUtil.instance.putString(StorageConstant.TOKEN, loginModel.token!);
    // StorageUtil.instance.putInt(StorageConstant.USER_ID, loginModel.userId!);
    // LogUtil.i('setLoginInfo TOKEN', loginModel.token!);
    StorageUtil.instance.putString(StorageConstant.USER, json.encode(loginModel.user));
  }

  /*
   * 用户被踢下线或者禁用，清空用户信息
   */
  static void clearUserInfo() {
    StorageUtil.instance.putString(StorageConstant.TOKEN, "");
    StorageUtil.instance.putInt(StorageConstant.USER_ID, 0);
    StorageUtil.instance.putString(StorageConstant.USER, "");
    StorageUtil.instance.putBool(StorageConstant.IS_LOGIN, false);
    StorageUtil.instance.putString(StorageConstant.DEVICE_INFO, "");
  }

  Future<bool> isLogin() async {
    bool? isLogin = await StorageUtil.instance.getBool(StorageConstant.IS_LOGIN);
    return ObjectUtil.isEmpty(isLogin) ? false : isLogin!;
  }

  Future<int?> getUserId() async {
    return await StorageUtil.instance.getInt(StorageConstant.USER_ID);
  }

  Future<String?> getToken() async {
    String? token = await StorageUtil.instance.getString(StorageConstant.TOKEN);
    return ObjectUtil.isEmptyString(token) ? "" : token;
  }

  Future<UserBean> getUser() async {
    String? userStr = await StorageUtil.instance.getString(StorageConstant.USER);
    UserBean userBean;
    if (!ObjectUtil.isEmptyString(userStr)) {
      userBean = UserBean.fromJson(jsonDecode(userStr!));
    } else {
      userBean = UserBean();
    }
    return userBean;
  }

  static Future<LoginModel> getLoginModel() async {
    if (ObjectUtil.isEmpty(instance.mLoginModel)) {
      String? loginModelStr = await StorageUtil.instance.getString(StorageConstant.DEVICE_INFO);
      instance.mLoginModel = LoginModel.fromJson(jsonDecode(loginModelStr!));
      instance.mLoginModel.token = await StorageUtil.instance.getString(StorageConstant.TOKEN);
      instance.mLoginModel.userId = await StorageUtil.instance.getInt(StorageConstant.USER_ID);
      instance.mLoginModel.user = await getInstance().getUser();
    }
    return instance.mLoginModel;
  }
}
