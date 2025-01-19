import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/bloc-observer.dart';
import 'package:univerisity_system/screens/attendance-method/attendance-method.dart';
import 'package:univerisity_system/screens/course-homepage/course-homepage.dart';
import 'package:univerisity_system/screens/homePage/homeScreen.dart';
import 'package:univerisity_system/screens/loginScreen/loginScreen.dart';
import 'package:univerisity_system/shared/cubit/cubit.dart';
import 'package:univerisity_system/shared/local/shared-prefrence.dart';

import 'firebase_options.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

