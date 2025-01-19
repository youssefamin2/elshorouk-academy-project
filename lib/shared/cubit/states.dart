abstract class HomePageState {}

class InitialHomePageStateState extends HomePageState {}
class HomePageLoadingState extends HomePageState {}

class HomePageSuccessState extends HomePageState {}

class HomePageErrorState extends HomePageState
{
  final String error;

  HomePageErrorState(this.error);


}


class GetLectureLoadingState extends HomePageState {}

class GetLectureSuccessState extends HomePageState {}

class GetLectureErrorState extends HomePageState
{
   final String error;

   GetLectureErrorState(this.error);

}




class AddStudentAttendanceLoadingState extends HomePageState {}
class AddStudentAttendanceSuccessState extends HomePageState {}
class AddStudentAttendanceErrorState extends HomePageState {
  final String error;
  AddStudentAttendanceErrorState(this.error);
}


class IncrementStudentCount extends HomePageState{}



class FinalizeLectureLoadingState extends HomePageState{}
class FinalizeLectureSuccessState extends HomePageState {}
class FinalizeLectureErrorState extends HomePageState
{
final String error;

FinalizeLectureErrorState(this.error);

}




