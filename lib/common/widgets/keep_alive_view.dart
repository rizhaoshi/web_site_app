import 'package:flutter/material.dart';

class KeepAliveView extends StatefulWidget {
  final Widget child;

  const KeepAliveView(this.child);

  @override
  State<KeepAliveView> createState() => _KeepAliveViewState();
}

class _KeepAliveViewState extends State<KeepAliveView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
