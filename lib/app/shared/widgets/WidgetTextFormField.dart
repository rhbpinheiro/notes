// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  TextEditingController controller;
  String? title;
  final String hintText;
  final String? initialValue;
  final bool? obscureText;
  final bool? autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextAlign textAlign;

  WidgetTextFormField
  (
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText,
      this.autofocus,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly,
      this.onChanged,
      required this.keyboardType,
      required this.textAlign,
      this.initialValue,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            obscureText: obscureText!,
            keyboardType: keyboardType,
            onChanged: onChanged,
            controller: controller,
            textAlign: textAlign,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1f5466),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
