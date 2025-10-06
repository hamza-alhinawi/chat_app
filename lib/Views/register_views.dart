// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snakbar.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                      'Register',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: CustomTextField(
                //         hintText: 'First Name',
                //         onChanged: (data) {},
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Expanded(
                //       child: CustomTextField(
                //         hintText: 'Last Name',
                //         onChanged: (data) {},
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
                CustomTextFromField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFromField(
                  hintText: 'password',
                  onChanged: (data) {
                    password = data;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // CustomTextField(
                //   hintText: 'Confirm password',
                //   onChanged: (data) {
                //     password = data;
                //   },
                // ),
                const SizedBox(height: 30),
                CustomContainerButtom(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await registerUser();
                        Navigator.pop(context);
                        if (!mounted) return;
                        showSnackBar(
                          context,
                          text: 'Sucess',
                          color: Colors.green,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (!mounted) return;
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            color: Colors.red,
                            context,
                            text: 'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            color: Colors.red,
                            context,
                            text: 'The account already exists for that email.',
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
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
                      title: ' Login',
                      ontap: () {
                        Navigator.pop(context);
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

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email ?? '',
      password: password ?? '',
    );
  }
}
