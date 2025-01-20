import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univerisity_system/constants.dart';
import 'package:univerisity_system/helper/toast.dart';
import 'package:univerisity_system/screens/homePage/homeScreen.dart';
import 'package:univerisity_system/screens/loginScreen/cubit/cubit.dart';
import 'package:univerisity_system/screens/loginScreen/cubit/states.dart';
import 'package:univerisity_system/widgets/customTextFeild.dart';
import 'package:univerisity_system/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => UniveristyLoginCubit(),
      child: BlocConsumer<UniveristyLoginCubit, UniveristyLoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          } else if (state is LoginErrorState) {
            showToast(message: 'Wrong email or password',color: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70.0,
                      ),
                      Image.asset(
                        loginImage,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Username:',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextFeild(
                        hintText: 'Enter your email address',
                        prefixIcon: const Icon(Icons.person),
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Password:',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      CustomTextFeild(
                        controller: passwordController,
                        type: TextInputType.text,
                        hintText: 'Enter your Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomButton(
                        text: 'Sign in',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            UniveristyLoginCubit.get(context).loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context);
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
