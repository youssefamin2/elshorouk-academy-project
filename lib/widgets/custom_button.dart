import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap, this.color=Colors.blue} );
final String? text;
final Function onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0)

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
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
        ),
      ),

    );
  }
}
