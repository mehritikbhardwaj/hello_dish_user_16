import 'package:flutter/material.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

class DCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function()? onIconTap;
  final Function()? onTap;

  const DCustomTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onTap,
    this.onIconTap,
  });

  @override
  State<DCustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<DCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onTap: widget.onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(widget.prefixIcon),
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                      onTap: widget.onIconTap, child: Icon(widget.suffixIcon)),
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: appThemeColor, width: 0.5)),
        ),
      ),
    );
  }
}
