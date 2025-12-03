import 'package:chat_app/Cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/Cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/Views/chat_view.dart';
import 'package:chat_app/Views/register_views.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snakbar.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LonginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  bool isLoading = false;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatView.id);
          showSnackBar(color: Colors.green, context, text: 'Sucess');
        } else if (state is LoginFailure) {
          showSnackBar(
            color: Colors.red,
            context,
            // if(){}
            text: state.errorMessage,
          );
        }
      },
      child: ModalProgressHUD(
        color: Colors.white,
        progressIndicator: Lottie.asset('assets/Animations/loading.json'),
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Image.asset(kLogo, height: 100),
                  Center(
                    child: Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextFromField(
                    hintText: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFromField(
                    hintText: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  CustomContainerButtom(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).loginUser(email: email!, password: password!);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an acount? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      CutomBottom(
                        title: ' Register',
                        ontap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterView.id,
                            arguments: email,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
