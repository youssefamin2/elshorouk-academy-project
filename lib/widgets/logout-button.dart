import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univerisity_system/helper/sign-out.dart';
import 'package:univerisity_system/screens/loginScreen/loginScreen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: GestureDetector(
              onTap: ()async
              {
                signOut(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ),
        ),
      ],
    );
  }
}
