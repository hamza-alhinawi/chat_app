import 'package:chat_app/Cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snakbar.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pop(context);
          showSnackBar(context, text: 'Sucess', color: Colors.green);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(color: Colors.red, context, text: state.errorMessage);
        }
      },
      builder: (context, state) {
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
                          await BlocProvider.of<RegisterCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
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
      },
    );
  }
}
