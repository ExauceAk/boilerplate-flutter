import 'package:flutter/material.dart';
import 'package:notable/screens/login_screen.dart';

import '../widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final emailController = TextEditingController();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    final confimPassword = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CloudClipper(),
              child: SizedBox(
                height: size.height * 0.5,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/auth_background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Text(
                    'Hello Welcome',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),

                  ),
                  Text(
                    'Hey, welcome back to your special place',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                  buildTextField(emailController, 'Email'),
                  buildTextField(userNameController, 'UserName'),
                  buildTextField(passwordController, 'Password'),
                  buildTextField(confimPassword, 'Confim Password'),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('Register'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 1,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CloudClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.2, size.height - 120,
        size.width * 0.4, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.5, size.height - 45, size.width * 0.6, size.height - 15);
    path.quadraticBezierTo(size.width * 0.65, size.height - 20,
        size.width * 0.7, size.height - 15);
    path.quadraticBezierTo(
        size.width * 0.9, size.height - 60, size.width, size.height - 15);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
