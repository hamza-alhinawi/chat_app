import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 50),
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

            // SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: CustomTextField(hintText: 'First Name')),
                const SizedBox(width: 10),
                Expanded(child: CustomTextField(hintText: 'Last Name')),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'password'),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Confirm password'),
            const SizedBox(height: 30),
            CustomContainerButtom(text: 'Register'),
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
            // SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
