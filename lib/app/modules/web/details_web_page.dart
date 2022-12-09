import 'package:flutter/material.dart';
import '../../../common/utils/object_util.dart';
import '../../../common/widgets/web_view_page.dart';
import '../../../common/widgets/common_app_bar.dart';

class DetailsWebPage extends StatelessWidget {
  final String webUrl;
  final String? title;
  final List<Widget>? actions;

  const DetailsWebPage({Key? key, required this.webUrl, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObjectUtil.isEmpty(title)
        ? Scaffold(
            body: WebViewPage(initialUrl: webUrl),
          )
        : Scaffold(
            appBar: CommonAppBar(title: title, actions: actions),
            body: WebViewPage(initialUrl: webUrl),
          );
  }
}
