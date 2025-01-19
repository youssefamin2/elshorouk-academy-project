import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/myDiv.dart';
import 'package:univerisity_system/models/courses.dart';
import 'package:univerisity_system/screens/Lecture-details/lecture-details.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/cubit/states.dart';

class LectureHistory extends StatelessWidget {
  const LectureHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => HomePageCubit()..getLectures(COURSEID!),
      child: BlocConsumer<HomePageCubit,HomePageState>(
        listener: (context,state)
        {

        },
        builder: (context,state)
        {
          final cubit = HomePageCubit.get(context);
          if (state is GetLectureLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0,),
                    const  Text(
                      'Lectures History',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    Expanded(
                      child: ListView.separated(itemBuilder:(context,index)=> buildLectureItem(cubit.lecturesList[index],context),
                          separatorBuilder:(context,index)=>  myDivider(),
                          itemCount: cubit.lecturesList.length),
                    ),
                  ],
                ),
              )

          );
        },
      ),
    );
  }
}

Widget buildLectureItem(LectureData lecture,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: GestureDetector(
    onTap: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LectureDetails(
         lectureName: lecture.name!, date: lecture.date!, numberOfStudents: lecture.numStudents!,)));
    },
    child: Row(
      children:
      [
        Text(
          lecture.name!,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,

          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  ),
);
