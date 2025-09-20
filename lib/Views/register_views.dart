import 'package:chat_app/Views/login_view.dart';
import 'package:chat_app/widgets/custom_container_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/cutom_bottom.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b475F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Password'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginView();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
