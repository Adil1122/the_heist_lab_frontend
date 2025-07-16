import 'package:flutter/material.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Views/Common/app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.validator,
    this.suffixicon,
    this.obsecuretext,
    required this.keyboard,
  });
  final TextEditingController controller;
  final String hinttext;
  final String? Function(String?) validator;
  final Widget? suffixicon;
  final bool? obsecuretext;
  final TextInputType keyboard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        color: Color(0XFF2A2A2A),

        child: TextFormField(
          keyboardType: keyboard,
          obscureText: obsecuretext ?? false,
          decoration: InputDecoration(
            hintText: hinttext,
            suffixIcon: suffixicon,
            hintStyle: appstyle(14, kDarkGrey, FontWeight.w500),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: kDarkGrey, width: 0.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.transparent, width: 0.5),
            ),
            border: InputBorder.none,
          ),
          controller: controller,
          cursorHeight: 25,
          style: appstyle(14, Colors.white, FontWeight.w300),
          validator: validator,
        ),
      ),
    );
  }
}
