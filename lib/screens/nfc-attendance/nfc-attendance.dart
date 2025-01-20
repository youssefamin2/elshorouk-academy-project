import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/navigate.dart';
import 'package:univerisity_system/helper/toast.dart';
import 'package:univerisity_system/screens/finissh-attendance-method/finish-attendance-method.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'package:univerisity_system/widgets/custom_button.dart';




class NfcAttendance extends StatelessWidget {
  const NfcAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state is AddStudentAttendanceSuccessState) {
            showToast(message: "Attendance recorded successfully!",color: Colors.green);
          } else if (state is AddStudentAttendanceErrorState) {
            showToast(message: state.error,color: Colors.red);
          }
        },
        builder: (context, state) {
          final cubit = HomePageCubit.get(context);
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Counter: ${cubit.count}', style: const TextStyle(fontSize: 20)),
                  CustomButton(
                    text: 'Read NFC',
                    onTap: () {

                      HomePageCubit.get(context).addStudentAttendanceFromNfc(
                        COURSEID!,
                        'lecture $LECTURENAME',
                        DateTime.now().toString()
                      );
                     // Replace 'courseID' dynamically
                    },
                  ),


                  CustomButton(
                    text: 'Finish',
                    onTap: ()
                    {


                        navigateTo(context, const AttendanceMethodFinish());

                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
