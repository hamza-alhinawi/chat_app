import 'package:chat_app/Views/register_views.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = 'LonginView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.asset('assets/images/scholar.png', height: 100),
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
            CustomTextField(hintText: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Password'),
            const SizedBox(height: 30),
            CustomContainerButtom(text: 'Login'),
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
                    Navigator.pushNamed(context, RegisterView.id);
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
