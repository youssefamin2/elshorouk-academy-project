import 'package:flutter/material.dart';

class ChooseAttendance extends StatelessWidget {
  const ChooseAttendance({super.key, this.text, required this.onTap, required this.icon, required this.color});
  final String? text;
  final Function onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    text!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                    ),
                  ),
                ),

                Icon(
                  icon!,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),

      ),
    );;
  }
}
