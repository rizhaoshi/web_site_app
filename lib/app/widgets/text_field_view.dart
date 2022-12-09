import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class TextFieldView extends StatefulWidget {
  String? hintText;
  ValueChanged<String>? submit;
  FocusNode focusNode;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  ValueChanged<String>? onChanged;
  TextEditingController controller;
  final StreamController<String> streamController = StreamController();
  final ShakeAnimationController shakeController = ShakeAnimationController();

  TextFieldView({
    Key? key,
    required this.controller,
    this.hintText,
    required this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.submit,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.streamController.stream,
        builder: (BuildContext cxt, AsyncSnapshot<dynamic> snapshot) {
          return ShakeAnimationWidget(
              isForward: false,
              shakeAnimationController: widget.shakeController,
              shakeAnimationType: ShakeAnimationType.LeftRightShake,
              child: TextField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                onChanged: widget.onChanged,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  errorText: snapshot.data,
                  labelText: widget.hintText,
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  hintText: widget.hintText,
                ),
                onSubmitted: widget.submit,
              ));
        });
  }
}
