import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader {
  final BuildContext context;
  var isOpen = false;

  Loader(this.context);
  void showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
        context: context,
        builder: ((context) {
          return LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 60,
          );
        }),
      );
    }
  }

  void hideLoader() {
    if(isOpen) {
      isOpen = false;
      Navigator.of(context).pop();
    }
  }
}