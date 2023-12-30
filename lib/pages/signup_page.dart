import 'package:flutter/material.dart';
import 'package:ig_clone/assets/images/Widgets/text_field_input.dart';
import 'package:ig_clone/auth_methods.dart';
import 'package:ig_clone/pages/user_login_page.dart';
import 'package:ig_clone/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _enrController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool isLoading = false;

  void signUpPressed() async {
    late AuthMethods auth = AuthMethods();
    setState(() {
      isLoading = true;
    });

    String res = await auth.signUpUser(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        enrollment: int.parse(_enrController.text));
    print(res); //debugging
    getSnackBar(res, context);
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/final_bg.png'),
                  fit: BoxFit.cover)),
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/LOGO.png',
                width: 150,
              ),

              const Spacer(),
              CustomTextField(
                hint: 'Name',
                textInputType: TextInputType.text,
                textEditingController: _nameController,
              ),
              const Spacer(
                flex: 1,
              ),
              // SizedBox(height: 5),
              CustomTextField(
                  hint: 'Enter your Enrollment Number',
                  textInputType: TextInputType.number,
                  textEditingController: _enrController,
                  isPass: false),
              const Spacer(),
              CustomTextField(
                hint: 'Enter your e-mail address',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const Spacer(
                flex: 1,
              ),
              // SizedBox(height: 5),
              SizedBox(
                height: 60,
                child: PasswordField(
                    hint: 'Create a password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true),
              ),

              const Spacer(),
              TextButton(
                onPressed: signUpPressed,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    foregroundColor: Colors.white),
                child: (isLoading == true)
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              // SizedBox(height: 5),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Center(
                        child: Container(
                            height: 20, width: 230, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?\t"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LoginPage()),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),

              const Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }
}
