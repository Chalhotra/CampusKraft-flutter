import 'package:flutter/material.dart';
import 'package:ig_clone/assets/images/Widgets/text_field_input.dart';
import 'package:ig_clone/auth_methods.dart';
import 'package:ig_clone/pages/employee_pages/emp_home.dart';

import 'package:ig_clone/pages/employee_signup_page.dart';

import 'package:ig_clone/pages/user_login_page.dart';
import 'package:ig_clone/utils.dart';

class EmployeeLoginPage extends StatefulWidget {
  const EmployeeLoginPage({super.key});

  @override
  State<EmployeeLoginPage> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginPage> {
  String profile = 'Employee';
  final TextEditingController _enrController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _enrController.dispose();
    _passwordController.dispose();
  }

  void loginEmployee() async {
    String res = await AuthMethods().loginEmployee(
        emp_id: int.parse(_enrController.text),
        password: _passwordController.text);
    getSnackBar(res, context);
    if (res == 'success') {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => ResponsiveLayout(
      //       webLayout: InstagramWebLayout(),
      //       mobileLayout: InstagramMobileLayout()),
      // ));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EmployeeHome()));
    }
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
              image: AssetImage(
                'lib/assets/images/final_bg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/LOGO.png',
                width: 200,
              ),
              const Spacer(flex: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Logging in as",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: "Student",
                          child: Text(
                            "Student",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Employee",
                          child: Text("Employee",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ],
                      value: profile,
                      onChanged: (value) {
                        setState(() {
                          profile = value!;
                        });
                        if (profile == "Student") {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hint: 'Enter your employee number',
                textInputType: TextInputType.number,
                textEditingController: _enrController,
              ),
              const Spacer(
                flex: 1,
              ),
              // SizedBox(height: 5),
              SizedBox(
                height: 60,
                child: PasswordField(
                    hint: 'Enter your password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true),
              ),
              const Spacer(),
              TextButton(
                  onPressed: loginEmployee,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      foregroundColor: Colors.white)),
              SizedBox(height: 5),
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
                      const Text("Don't have an account?\t"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                                  const EmployeeSignUpPage()),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(flex: 18)
            ],
          ),
        ),
      ),
    );
  }
}
