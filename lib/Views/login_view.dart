import 'package:chat_app/Views/chat_view.dart';
import 'package:chat_app/Views/register_views.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snakbar.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});
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
    return ModalProgressHUD(
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
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        Navigator.pushNamed(context, ChatView.id);
                        await loginUser();
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        showSnackBar(
                          color: Colors.green,
                          context,
                          text: 'Sucess',
                        );
                        isLoading = false;
                      } on FirebaseAuthException catch (e) {
                        if (!mounted) return;
                        if (e.code == 'weak-password') {
                          isLoading = false;

                          showSnackBar(
                            color: Colors.red,
                            // ignore: use_build_context_synchronously
                            context,
                            text: 'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          isLoading = false;

                          showSnackBar(
                            color: Colors.red,
                            // ignore: use_build_context_synchronously
                            context,
                            text: 'The account already exists for that email.',
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        showSnackBar(
                          color: Colors.red,
                          context,
                          text: e.toString(),
                        );
                      } finally {
                        if (!mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                      isLoading = false;
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
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email ?? '',
      password: password ?? '',
    );
  }
}
