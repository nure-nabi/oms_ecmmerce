import 'package:flutter/material.dart';


import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';

class TextFormDecoration {
  static decoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    String? errorText,
    EdgeInsets? containPadding,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      prefixIcon:
          (prefixIcon == null) ? null : Icon(prefixIcon, ),
      suffixIcon:
          (suffixIcon == null) ? null : Icon(suffixIcon,),
      suffix: suffix,
      prefix: prefix,
      errorText: errorText,
      fillColor: textFormFieldColor,
      filled: true,
      counter: const Offstage(),
      isDense: true,
      hintText: hintText,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      hintStyle: hintStyle ?? hintTextStyle,
      contentPadding: containPadding ?? const EdgeInsets.all(10.0),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.white)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
