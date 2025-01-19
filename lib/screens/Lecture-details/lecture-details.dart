import 'package:flutter/material.dart';

class LectureDetails extends StatelessWidget {
  const LectureDetails({super.key,  this.lectureName,  this.date,  this.numberOfStudents});
  final String? lectureName;
  final String ?date;
  final int? numberOfStudents;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:
          [
            const SizedBox(height: 40.0,),
            const  Text(
              'Lectures History',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold

              ),
            ),
              Text(
              '$lectureName details',
            ),
            const SizedBox(height: 150.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10,),
                Text(
                  '$lectureName details:',
                  style: TextStyle(
                    fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),
            const SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Text(
                  '$lectureName date :  ${date!}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),
            const SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Text(
                  '$lectureName number of students attend: $numberOfStudents',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),
            const SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Text(
                  '$lectureName time: 9:15-11:30',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),

          ],
        ),
      ),

    );
  }
}
