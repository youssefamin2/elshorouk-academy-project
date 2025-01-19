import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final TextInputType type;


  const CustomTextFeild({super.key, required this.hintText, required this.prefixIcon,  this.suffixIcon, required this.controller,required this.type });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: type,
        controller:controller ,
        validator: (String? value)
        {
          if(value!.isEmpty)
          {
            return'Field is required';
          }
        },

        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            ),
              borderRadius: BorderRadius.circular(20)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              ),
              borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              ),
              borderRadius: BorderRadius.circular(20)
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true, // Enable background color
          fillColor: Colors.grey[450],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
