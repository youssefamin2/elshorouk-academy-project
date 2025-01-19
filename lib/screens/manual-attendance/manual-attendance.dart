import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/navigate.dart';
import 'package:univerisity_system/screens/finissh-attendance-method/finish-attendance-method.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'package:univerisity_system/shared/local/shared-prefrence.dart';
import 'package:univerisity_system/widgets/customTextFeild.dart';
import 'package:univerisity_system/widgets/custom_button.dart';

class ManualAttendance extends StatelessWidget {
  const ManualAttendance({super.key, this.courseID, this.courseName, this.teacherName});
  final String? courseID;
  final String ?courseName;
  final String ?teacherName;

  @override
  Widget build(BuildContext context) {
    var IDcontroller = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var lectureName;
    lectureName=CacheHelper.getdata(key: 'lectureName');
    return BlocProvider(
      create: (BuildContext context) => HomePageCubit()..getCourses(),
      child: BlocConsumer<HomePageCubit,HomePageState>(
        listener:(context,state)
        {

        },
        builder: (context,state)
        {
          return  Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children:
                    [
                      const SizedBox(height: 50,),
                      Image.asset(
                        loginImage,
                        height: 100,
                      ),
                      const Text(
                         'Manual Attendance',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ),

                      const Text(
                        'Enter the student ID in the text box then',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),

                      const Text(
                        'click Attend.',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 50,),

                      const Row(
                        children: [
                          SizedBox(width: 20,),
                          Text(
                            'Student ID: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFeild
                          (
                          hintText: '',
                          prefixIcon:const Icon(Icons.person),
                          controller:IDcontroller ,
                          type: TextInputType.number,
                        ),
                      ),
                       Row(
                        children: [
                          Spacer(flex:10),
                          Text(
                            'counter:${HomePageCubit.get(context).count}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      CustomButton(
                        text: 'Attend',
                        onTap: () {
                          final studentID = IDcontroller.text;
                          if (studentID.isNotEmpty)
                          {
                            HomePageCubit.get(context).addManualAttendance(
                                COURSEID!,
                                studentID,
                                'Manuall test7',
                                DateTime.now().toString());

                          }
                        },
                      ),
                      const SizedBox(height: 30,),
                      CustomButton(
                        text: 'Finish',
                        onTap: ()
                        {
                          if(formKey.currentState!.validate())
                          {

                            navigateTo(context, const AttendanceMethodFinish());
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}

