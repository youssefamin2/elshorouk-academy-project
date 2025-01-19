import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:univerisity_system/helper/toast.dart';
import 'package:univerisity_system/models/courses.dart';
import 'package:univerisity_system/shared/cubit/states.dart';
import 'dart:typed_data';

import 'package:univerisity_system/shared/local/shared-prefrence.dart';


class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(InitialHomePageStateState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  // Temporary list to store attendance data during the session
  List<String> tempAttendanceData = [];

  // Initialize lecture name
  void initializeLectureName(String lectureName) {
    CacheHelper.saveData(key: 'lectureName', value: lectureName);
  }

  List<Courses> coursesList = [];
  List<LectureData> lecturesList = [];

  // Fetch all courses
  void getCourses() async {
    emit(HomePageLoadingState());

    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(
          'courses').get();
      coursesList.clear();

      for (var doc in querySnapshot.docs) {
        coursesList.add(Courses.fromJson(doc.data()));
      }

      emit(HomePageSuccessState());
    } catch (error) {
      emit(HomePageErrorState(error.toString()));
    }
  }

  // Fetch lectures for a specific course
  void getLectures(String courseID) async {
    emit(GetLectureLoadingState());

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .where('ID', isEqualTo: courseID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final course = Courses.fromJson(doc.data());
        lecturesList = course.lectures?.data ?? [];
        emit(GetLectureSuccessState());
      } else {
        throw Exception("Course not found.");
      }
    } catch (error) {
      emit(GetLectureErrorState(error.toString()));
    }
  }

  int count = 0;




  void addManualAttendance(String courseID, String studentID, String lectureName, String lectureDate) async {
    emit(AddStudentAttendanceLoadingState());

    try {
      // Use `where` to find the course by its ID (filtering)
      final querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .where('ID', isEqualTo: courseID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final course = Courses.fromJson(doc.data());

        // Check if the student is enrolled in the course
        if (course.studentsEnroll!.contains(studentID)) {
          // Find the lecture where the student is trying to mark attendance
          final lectureIndex = course.lectures?.data.indexWhere(
                (lecture) => lecture.name == lectureName,
          );
          print('lecture index equal=$lectureIndex');
          if (lectureIndex != -1) {
            // The lecture already exists
            final lecture = course.lectures?.data[lectureIndex!];

            // Check if the student has already attended this lecture
            if (lecture?.students.contains(studentID) ?? false) {
              print('Student has already attended this lecture.');
              emit(AddStudentAttendanceErrorState('Student has already attended this lecture.'));
            } else {
              // If the student hasn't attended yet, add them to the lecture's student list
              lecture?.students.add(studentID);

              // Update the lecture's student count
              lecture?.numStudents = lecture?.students.length ?? 0;
               count= lecture?.students.length ?? 0;
               emit(IncrementStudentCount());

              // Update the course in Firestore
              await FirebaseFirestore.instance
                  .collection('courses')
                  .doc(doc.id) // Update the course by its ID
                  .update(course.toMap());

              emit(AddStudentAttendanceSuccessState());
            }
          } else {
            // Lecture doesn't exist, add a new lecture
            final newLecture = LectureData(
              name: lectureName,
              date: lectureDate,
              numStudents: 1,
              students: [studentID],  // Add the student to the new lecture
            );
            course.lectures?.data.add(newLecture);

            // Update the course with new lecture data
            await FirebaseFirestore.instance
                .collection('courses')
                .doc(doc.id) // Update the course by its ID
                .update(course.toMap());

            emit(AddStudentAttendanceSuccessState());
          }
        } else {
          print('Student ID does not exist in the enrolled list.');
          emit(AddStudentAttendanceErrorState('Student ID does not exist in the enrolled list.'));
        }
      } else {
        print('Course not found.');
        emit(AddStudentAttendanceErrorState('Course not found.'));
      }
    } catch (error) {
      emit(AddStudentAttendanceErrorState('Error updating attendance: $error'));
    }
  }


  void addStudentAttendanceFromNfc(String courseID, String lectureName, String lectureDate) async {
    emit(AddStudentAttendanceLoadingState());

    try {
      // Check if NFC is available
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) {
        emit(AddStudentAttendanceErrorState("NFC is not available on this device."));
        return;
      }

      // Start NFC session
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            emit(AddStudentAttendanceErrorState("Tag is not NDEF formatted."));
            NfcManager.instance.stopSession();
            return;
          }

          final message = await ndef.read();
          if (message.records.isNotEmpty) {
            final payload = String.fromCharCodes(message.records.first.payload);
            final studentID = payload.substring(3); // Assuming payload starts with some prefix

            // Fetch the course by its ID
            final querySnapshot = await FirebaseFirestore.instance
                .collection('courses')
                .where('ID', isEqualTo: courseID)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              final doc = querySnapshot.docs.first;
              final course = Courses.fromJson(doc.data());

              // Check if the student is enrolled in the course
              if (course.studentsEnroll!.contains(studentID)) {
                // Find the lecture where the student is trying to mark attendance
                final lectureIndex = course.lectures?.data.indexWhere(
                      (lecture) => lecture.name == lectureName,
                );

                if (lectureIndex != -1) {
                  // The lecture already exists
                  final lecture = course.lectures?.data[lectureIndex!];

                  // Check if the student has already attended this lecture
                  if (lecture?.students.contains(studentID) ?? false) {
                    print('Student has already attended this lecture.');
                    emit(AddStudentAttendanceErrorState('Student has already attended this lecture.'));
                  } else {
                    // Add student to the lecture's student list
                    lecture?.students.add(studentID);

                    // Update the lecture's student count
                    lecture?.numStudents = lecture?.students.length ?? 0;

                    // Update Firestore
                    await FirebaseFirestore.instance
                        .collection('courses')
                        .doc(doc.id)
                        .update(course.toMap());

                    emit(AddStudentAttendanceSuccessState());
                  }
                } else {
                  // Lecture doesn't exist, add a new lecture
                  final newLecture = LectureData(
                    name: lectureName,
                    date: lectureDate,
                    numStudents: 1,
                    students: [studentID],
                  );
                  course.lectures?.data.add(newLecture);

                  // Update Firestore
                  await FirebaseFirestore.instance
                      .collection('courses')
                      .doc(doc.id)
                      .update(course.toMap());

                  emit(AddStudentAttendanceSuccessState());
                }
              } else {
                emit(AddStudentAttendanceErrorState("Student ID does not exist in the enrolled list."));
              }
            } else {
              emit(AddStudentAttendanceErrorState("Course not found."));
            }
          } else {
            emit(AddStudentAttendanceErrorState("NFC tag has no records."));
          }
        } catch (error) {
          emit(AddStudentAttendanceErrorState("Error reading NFC tag: $error"));
        } finally {
          NfcManager.instance.stopSession();
        }
      });
    } catch (error) {
      emit(AddStudentAttendanceErrorState("Error starting NFC session: $error"));
    }
  }



}



  // Add student to temporary attendance list (manual attendance)
// // Unified function to add a student (NFC or manual)
//   void addStudentAttendance(String studentID) {
//     // Check if the student has already attended
//     if (!tempAttendanceData.contains(studentID)) {
//       tempAttendanceData.add(studentID);
//       count++;
//       emit(AddStudentAttendanceSuccessState());
//     } else {
//       emit(AddStudentAttendanceErrorState("Student has already attended this lecture."));
//     }
//   }
//
//   void addStudentAttendanceFromNfc() async {
//     try {
//       bool isAvailable = await NfcManager.instance.isAvailable();
//       if (!isAvailable) {
//         emit(AddStudentAttendanceErrorState("NFC is not available on this device."));
//         return;
//       }
//
//       await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//         final ndef = Ndef.from(tag);
//         if (ndef == null) {
//           emit(AddStudentAttendanceErrorState("Tag is not NDEF formatted."));
//           NfcManager.instance.stopSession();
//           return;
//         }
//
//         final message = await ndef.read();
//         if (message.records.isNotEmpty) {
//           final payload = String.fromCharCodes(message.records.first.payload);
//           final studentID = payload.substring(3);
//
//           if (!tempAttendanceData.contains(studentID)) {
//             tempAttendanceData.add(studentID);
//             count++;
//             emit(AddStudentAttendanceSuccessState());
//           } else {
//             emit(AddStudentAttendanceErrorState("Student has already attended this lecture."));
//           }
//         } else {
//           emit(AddStudentAttendanceErrorState("NFC tag has no records."));
//         }
//
//         NfcManager.instance.stopSession();
//       });
//     } catch (error) {
//       emit(AddStudentAttendanceErrorState(error.toString()));
//     }
//   }
//   void markAttendance(String studentID) {
//     if (!tempAttendanceData.contains(studentID)) {
//       tempAttendanceData.add(studentID);
//       count = tempAttendanceData.length;
//       print("Attendance marked: $tempAttendanceData");
//     } else {
//       print("Student $studentID is already marked present.");
//     }
//   }
//
//   void finalizeLecture(String courseID, String lectureName, String lectureDate) async {
//     emit(FinalizeLectureLoadingState());
//
//     try {
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('courses')
//           .where('ID', isEqualTo: courseID)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final doc = querySnapshot.docs.first;
//         final course = Courses.fromJson(doc.data());
//
//         print("Course Data Before Update: ${course.toMap()}");
//         print("Temp Attendance Data: $tempAttendanceData, Count: $count");
//
//         if (tempAttendanceData.isEmpty) {
//           print("No attendance data provided. Adding lecture with zero students.");
//         }
//
//         final existingLectureIndex = course.lectures?.data.indexWhere(
//               (lecture) => lecture.name == lectureName,
//         );
//
//         if (existingLectureIndex != null && existingLectureIndex != -1) {
//           print("Updating existing lecture: ${course.lectures!.data[existingLectureIndex].name}");
//           course.lectures!.data[existingLectureIndex].numStudents = tempAttendanceData.length;
//           course.lectures!.data[existingLectureIndex].students = List.from(tempAttendanceData);
//         } else {
//           print("Adding new lecture: $lectureName");
//           final newLecture = LectureData(
//             name: lectureName,
//             date: lectureDate,
//             numStudents: tempAttendanceData.length,
//             students: List.from(tempAttendanceData),
//           );
//           course.lectures?.data.add(newLecture);
//         }
//
//         print("Course Data After Update: ${course.toMap()}");
//
//         await FirebaseFirestore.instance
//             .collection('courses')
//             .doc(doc.id)
//             .update(course.toMap());
//
//         print("Firebase update successful.");
//         tempAttendanceData.clear();
//         count = 0;
//
//         emit(FinalizeLectureSuccessState());
//       } else {
//         print("Course not found.");
//         emit(FinalizeLectureErrorState("Course not found."));
//       }
//     } catch (error) {
//       print("Error during Firebase update: $error");
//       emit(FinalizeLectureErrorState(error.toString()));
//     }
//   }


