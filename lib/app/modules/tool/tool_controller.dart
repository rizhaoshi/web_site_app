import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../constant/config.dart';
import '../../model/art_bean.dart';

class ToolController extends GetxController {
  List<ArtBean> artBeans = [];
  late EasyRefreshController refreshController;
  int page = 1;
  int limit = Config.LIMIT;
  bool hasMore = true;
  bool isError = false;

  @override
  void onInit() {
    super.onInit();
    refreshController = EasyRefreshController();
    getInfoList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onRefresh() async {
    page = 1;
    await getInfoList();
    refreshController.finishRefresh();
    refreshController.resetLoadState();
  }

  onLoad() async {
    if (hasMore) await getInfoList(push: true);
    refreshController.finishLoad(noMore: !hasMore);
  }

  getInfoList({bool push = false}) async {

  }
}
