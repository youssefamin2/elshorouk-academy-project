import 'package:flutter/material.dart';

class CustomButtonCourse extends StatelessWidget {
  const CustomButtonCourse({super.key, required this.text, required this.onTap});
  final String? text;
  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return Container(


      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight:Radius.circular(20.0),
            bottomRight:Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),

      ),

      child: TextButton(
        onPressed: ()
        {
          onTap();
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          child: Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
        ),
      ),

    );
  }
}
