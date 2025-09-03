import 'package:e_commerce_responsive/framework/controllers/auth/signup/signup_controller.dart';
import 'package:e_commerce_responsive/ui/utils/consts/app_key.dart';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dashbord/mobile/dashbord.dart';
import '../../../utils/consts/theam/app_text_style.dart';
import '../../helper/text_field_email.dart';
import '../../helper/text_fild_password.dart';
import '../signup/signup.dart';

class Login extends ConsumerWidget {
  Login({super.key});

  bool isValidate(String value) {
    if (value!.isEmpty ||
        !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
      return false;
    }
    return true;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Center(
                  child: Text(
                    "Login",
                    style: AppTextStyle.headerStyle(28, FontWeight.w900),
                  ),
                ),

                SizedBox(height: 30),

                Text(
                  "Email",
                  style: AppTextStyle.headerStyle(24, FontWeight.w500),
                ),

                SizedBox(height: 10),

                TextFieldEmail(
                  controller: emailController,
                  validator: (value) {
                    if (value == null) {
                      return "Email is required";
                    }
                    if (!isValidate(value)) {
                      return "Enter valid email";
                    }
                  },
                  errorText: Text("enter valid email"),
                ),

                SizedBox(height: 30),

                Text(
                  "Password",
                  style: AppTextStyle.headerStyle(24, FontWeight.w500),
                ),

                SizedBox(height: 10),

                TextFieldPassword(
                  controller: passwordController,
                  errorText: Text("Enter password"),
                  validator: (String? value) {
                    if (value!.length < 8) {
                      return "length must be greater than 8";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(height: 40),

                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String result = await SignUpController().checkUser(
                          emailController.text,
                          passwordController.text,
                        );
                        if (result == login_success) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  result == user_not_found
                                      ? user_not_found
                                      : wrong_password,
                                ),
                                content: Text(
                                  result == user_not_found
                                      ? 'Please signup'
                                      : 'Wrong password',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // Dismiss the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 60),
                      backgroundColor: AppColors.secondary,
                    ),
                    child: Text(
                      "Login",
                      style: AppTextStyle.headerStyle(24, FontWeight.w500),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account? ",
                      style: AppTextStyle.headerStyle(16, FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: AppTextStyle.headerStyle(16, FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
