import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/navigate-and-finish.dart';
import 'package:univerisity_system/helper/navigate.dart';
import 'package:univerisity_system/screens/homePage/homeScreen.dart';
import 'package:univerisity_system/screens/manual-attendance/manual-attendance.dart';
import 'package:univerisity_system/screens/nfc-attendance/nfc-attendance.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'package:univerisity_system/shared/local/shared-prefrence.dart';
import 'package:univerisity_system/widgets/choose-attendance.dart';
import 'package:univerisity_system/widgets/custom_button.dart';

class AttendanceMethodFinish extends StatelessWidget {
  const AttendanceMethodFinish({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current lecture name from CacheHelper and ensure it's a String
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // Handle state changes here
          if (state is FinalizeLectureSuccessState) {
            // Navigate to home screen after finalizing the lecture
            navigateAndFinish(context, const HomeScreen());
          } else if (state is FinalizeLectureErrorState) {
            // Show an error message if finalizing the lecture fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    Image.asset(
                      loginImage,
                      height: 100,
                    ),
                    const Text(
                      'Take Attendance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      'Please choose a method to take the',
                    ),
                    const Text(
                      'attendance with.',
                    ),
                    const SizedBox(height: 50.0),
                    ChooseAttendance(
                      text: 'NFC',
                      onTap: () {
                        // Navigate to NFC attendance screen
                        navigateTo(context, const NfcAttendance());
                      },
                      icon: Icons.nfc_sharp,
                      color: Colors.pinkAccent,
                    ),
                    const SizedBox(height: 20.0),
                    ChooseAttendance(
                      text: 'Manually',
                      onTap: () {
                        // Navigate to manual attendance screen
                        navigateTo(context, const ManualAttendance());
                      },
                      icon: CupertinoIcons.hand_draw_fill,
                      color: Colors.yellow,
                    ),
                    const SizedBox(height: 20.0),
                    CustomButton(
                      text: 'Finish',
                      onTap: () {
                        print('lecture name is $LECTURENAME');
                        print('========================');
                        int lectureNumber = int.tryParse(LECTURENAME) ?? 0;
                        print('lecture number is $lectureNumber');

                        lectureNumber++;
                        CacheHelper.saveData(
                          key: 'lectureName',
                          value: lectureNumber.toString(),
                        );

                        LECTURENAME=lectureNumber.toString();
                        print('lecture name is $LECTURENAME');
                        navigateAndFinish(context, const HomeScreen());

                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}