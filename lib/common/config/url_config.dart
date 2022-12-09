class UrlConfig {
  /*
   * 是否调试模式
   */
  static const bool IS_DEBUG = true;

  /*
    * 服务器地址(测试)
    */
  static const String SERVER_HOST_DEBUG = "http://gwtest.qiuxuebao.com/";

  /*
    * 服务器地址(正式)
    */
  static const String SERVER_HOST_RELEASE = "https://gw.qiuxuebao.com";

  /*
    * 服务器地址
    */
  static const String SERVER_HOST = IS_DEBUG ? SERVER_HOST_DEBUG : SERVER_HOST_RELEASE;

  /*
   * 工具首頁_智能选校
   */
  static final String TOOLS_HOME_SMART_SCHOOL_DEBUG = "http://mtest.qiuxuebao.com/smartSchoolChoose/smart-school-choose?showH5Header=1";

  /*
   * 工具首頁_智能选校
   */
  static final String TOOLS_HOME_SMART_SCHOOL_RELEASE = "https://m.qiuxuebao.com/smartSchoolChoose/smart-school-choose?showH5Header=1";

  /*
   * 工具首頁_智能选校
   */
  static final String TOOLS_HOME_SMART_SCHOOL = IS_DEBUG ? TOOLS_HOME_SMART_SCHOOL_DEBUG : TOOLS_HOME_SMART_SCHOOL_RELEASE;

  /*
   * 用户协议
   */
  static final String USER_AGREEMENT = "https://www.qiuxuebao.com/app/user-agreement-20220613.html";

  /*
   * 隐私政策
   */
  static final String PRIVACY_PROTOCOL = "https://www.qiuxuebao.com/app/privacy-policy-20220613.html";

  /*
   * 关于我们
   */
  static final String ABOUT_US_H5URL = "http://www.qiuxuebao.com/app/about.html";
}
