// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final bool autofocus;
  final Widget? icon;

  const WidgetTextFormField({
    Key? key,
    required this.controller,
    required this.title,
    required this.obscureText,
    required this.autofocus,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autofocus: autofocus,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: icon,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1f5466),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            
          ),
        ],
      ),
    );
  }
}
