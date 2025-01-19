import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/navigate.dart';
import 'package:univerisity_system/screens/manual-attendance/manual-attendance.dart';
import 'package:univerisity_system/screens/nfc-attendance/nfc-attendance.dart';
import 'package:univerisity_system/widgets/choose-attendance.dart';

class AttendanceMethod extends StatelessWidget {
  const AttendanceMethod({super.key, this.courseID, this.courseName, this.teacherName, });
  final String? courseID;
  final String ?courseName;
  final String ?teacherName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50.0,),
              Image.asset(
                loginImage,
                height: 100,
              ),
              const Text(
                'Take Attendance',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              const Text(
                'Please choose a method to take the',
          
              ),
              const Text(
                'attendance with.',
          
              ),
              const SizedBox(height: 50.0,),
              ChooseAttendance(
                text: 'NFC',
                onTap: ()
              {
                   navigateTo(context,  NfcAttendance());
              },
                icon:Icons.nfc_sharp, color: Colors.pinkAccent ,
              ),
              const SizedBox(height: 40.0,),
              ChooseAttendance(
                text: 'Manually',
                onTap: ()
                {
          
                  navigateTo(context,  ManualAttendance(courseID: courseID!,courseName: courseName!,teacherName: teacherName,));
          
                },
                icon: CupertinoIcons.hand_draw_fill,
                color: Colors.yellow,
              ),
          
          
            ],
          ),
        ),
      ),

    );
  }
}
