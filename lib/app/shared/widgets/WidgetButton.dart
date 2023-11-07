import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color background;
  final Color titleColor;
  final Function() function;

  const WidgetButton({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.background,
    required this.titleColor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
      ),
    );
  }
}
