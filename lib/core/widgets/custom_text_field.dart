import 'package:chat_app/core/helper/constants.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.inputDecoration,
    this.controller,
    this.color,
  });

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? hintText;
  final bool obscureText;
  final InputDecoration? inputDecoration;
  final TextEditingController? controller;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      style: TextStyle(
        color: color,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: inputDecoration ??
          InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: kWhiteColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: kWhiteColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: kWhiteColor,
              ),
            ),
          ),
    );
  }
}
