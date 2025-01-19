import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/screens/Lecture-history/lecture-history.dart';
import 'package:univerisity_system/screens/attendance-method/attendance-method.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'package:univerisity_system/widgets/course-selection-button.dart';
import 'package:univerisity_system/widgets/logout-button.dart';

class CourseHomePage extends StatelessWidget {
  const CourseHomePage({super.key,  this.courseID, this.courseName, this.teacherName, this.lectureID, this.lectureName, this.studentId, this.studentName});
  final String? courseID;
  final String ?courseName;
  final String ?teacherName;
  final String ?lectureID;
  final String? lectureName;
  final String ?studentId;
  final String ?studentName;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomePageCubit()..getCourses(),
      child: BlocConsumer<HomePageCubit,HomePageState>(
        listener:(context,state){} ,
        builder: (context,state)
        {
          final cubit = HomePageCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                const LogoutButton(),
                const SizedBox(height: 50.0,),
                Image.asset(
                  loginImage,
                  height: 100,
                ),
                Text(
                  '$courseName Homepage',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),

                 Text(
                  'Course ID: ${COURSEID!}.',

                ),

                 Text(
                  'Teacher: ${teacherName!}.',
                ),
                const SizedBox(height: 100.0,),
                CustomButtonCourse(text: 'Take attendance', onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AttendanceMethod(courseID: courseID,courseName: courseName,teacherName: teacherName,)),
                  );


                },
                ),
                const SizedBox(height: 40.0,),
                CustomButtonCourse(text: 'Lecture History', onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LectureHistory()),
                  );
                },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
