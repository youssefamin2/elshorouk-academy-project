import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/helper/toast.dart';
import 'package:univerisity_system/screens/homePage/homeScreen.dart';
import 'package:univerisity_system/screens/loginScreen/cubit/states.dart';

class UniveristyLoginCubit extends Cubit<UniveristyLoginStates> {
  UniveristyLoginCubit() : super(LoginInitialState());

  static UniveristyLoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginInitialState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('Wrong password'));
      } else {
        emit(LoginErrorState('An unexpected error occurred: ${e.message}'));
      }
    } catch (e) {
      emit(LoginErrorState('An unknown error occurred'));
    }
  }


}
