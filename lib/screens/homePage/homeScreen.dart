import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/models/courses.dart';
import 'package:univerisity_system/screens/course-homepage/course-homepage.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'package:univerisity_system/widgets/logout-button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.lectureName});
  final int ?lectureName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => HomePageCubit()..getCourses(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state is HomePageErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            print("Error: ${state.error}");  // Log the error message

          }
        },
        builder: (context, state) {
          final cubit = HomePageCubit.get(context);

          return Scaffold(
            body: Column(
              children: [
                const LogoutButton(),
                const SizedBox(height: 50.0),
                Image.asset(
                  loginImage,
                  height: 100,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Please choose a course from your assigned',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'List of courses.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40.0),
                Expanded(
                  child: state is HomePageSuccessState && cubit.coursesList.isNotEmpty
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.separated(
                      itemBuilder: (context, index) => CourseBuilder(cubit.coursesList[index],context),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 30),
                      itemCount: cubit.coursesList.length,
                    ),
                  )
                      : const Center(
                    child: Text(
                      'No courses available.',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget CourseBuilder(Courses course,context) => GestureDetector(
  onTap: ()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>(CourseHomePage(
      courseID:course.id!,courseName: course.name!, teacherName: course.teacherName!,
    ))));
    COURSEID=course.id;
  },
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Text(
        course.name!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    ),
  ),
);
