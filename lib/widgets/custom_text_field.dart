import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? suffixText;
  bool hasIcon;
  final Icon? prefixIcon;
  String? prefixText;
  double margin;
  bool isPassObscure;
  String? hintText;
  TextInputType inputType;


   CustomTextField(
      {Key? key,
        required this.label,
        required this.controller,
        this.isPassObscure = false,
        this.inputType = TextInputType.text,
        this.prefixText,
        this.hasIcon = false,
        this.margin = 10.0,
        this.suffixText,
        this.hintText,
        this.prefixIcon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: widget.margin),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  TextFormField(
        keyboardType: widget.inputType,
        obscureText: widget.isPassObscure,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black54),
        decoration:  InputDecoration(
          prefixText: widget.prefixText ?? '',
          hintText: widget.hintText ?? '',
          prefixIcon: widget.prefixIcon,
          border: InputBorder.none,
          labelText: widget.label,
          suffixIcon: widget.hasIcon
            ?IconButton(
              onPressed: () {
                setState(() {
                  widget.isPassObscure = !widget.isPassObscure;
                });
              },
              icon: widget.isPassObscure
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off))
            : null
        ),
      ),
    );
  }
}
