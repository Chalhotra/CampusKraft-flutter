import 'package:flutter/material.dart';
import 'package:ig_clone/assets/images/Widgets/text_field_input.dart';
import 'package:ig_clone/auth_methods.dart';
import 'package:ig_clone/pages/employee_login_page.dart';

import 'package:ig_clone/utils.dart';

class EmployeeSignUpPage extends StatefulWidget {
  const EmployeeSignUpPage({super.key});

  @override
  State<EmployeeSignUpPage> createState() => _EmployeeSignUpPageState();
}

class _EmployeeSignUpPageState extends State<EmployeeSignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _enrController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
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

    String res = await auth.signUpEmployee(
        number: int.parse(_phoneController.text),
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        emp_id: int.parse(_enrController.text),
        service: _serviceController.text);
    print(res);
    getSnackBar(res, context);
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => EmployeeLoginPage()));
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
          decoration: BoxDecoration(
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

              Spacer(),
              CustomTextField(
                hint: 'Name',
                textInputType: TextInputType.text,
                textEditingController: _nameController,
              ),
              Spacer(
                flex: 1,
              ),
              // SizedBox(height: 5),
              CustomTextField(
                  hint: 'Enter your Employee Number',
                  textInputType: TextInputType.number,
                  textEditingController: _enrController,
                  isPass: false),
              Spacer(),
              CustomTextField(
                hint: 'Enter your e-mail address',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              Spacer(
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

              Spacer(),
              CustomTextField(
                  textInputType: TextInputType.text,
                  textEditingController: _phoneController,
                  hint: "Enter your phone number"),
              Spacer(),
              CustomTextField(
                  textInputType: TextInputType.text,
                  textEditingController: _serviceController,
                  hint: "What service do you provide"),
              Spacer(),
              TextButton(
                  onPressed: signUpPressed,
                  child: (isLoading == true)
                      ? CircularProgressIndicator()
                      : Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      foregroundColor: Colors.white)),
              // SizedBox(height: 5),
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
                      Text("Already have an account?\t"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => EmployeeLoginPage()),
                            ),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),

              Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }
}
