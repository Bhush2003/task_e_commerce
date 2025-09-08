import 'dart:io';
import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:e_commerce_responsive/responsive_dashboard.dart';
import 'package:e_commerce_responsive/ui/auth/mobile/login/login.dart';
import 'package:e_commerce_responsive/ui/dashbord/mobile/dashbord.dart';
import 'package:e_commerce_responsive/ui/dashbord/web/dashbord.dart';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../framework/controllers/auth/signup/signup_controller.dart';
import '../../../utils/consts/theam/app_text_style.dart';
import '../../helper/text_field_email.dart';
import '../../helper/text_fild_password.dart';
import '../login/login.dart';

class SignupWeb extends StatefulWidget {
  const SignupWeb({super.key});

  @override
  State<SignupWeb> createState() => _SignupState();
}

class _SignupState extends State<SignupWeb> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  File? image;
  Future getImage(ImageSource img) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: img);
    if (pickedFile == null) return;
    final imageTemp = File(pickedFile.path);
    setState(() {
      image = imageTemp;
    });
  }

  final _formKey = GlobalKey<FormState>();

  bool isValidate(String value) {
    if (value.isEmpty ||
        !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "SignUp",
                  style: AppTextStyle.headerStyle(28, FontWeight.w900),
                ),

                SizedBox(height: 15),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPicker(context: context);
                      });
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : AssetImage(""),
                      child: image != null
                          ? Container()
                          : Text(
                              "Pick Image",
                              style: AppTextStyle.headerStyle(
                                16,
                                FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: AppTextStyle.headerStyle(20, FontWeight.w500),
                  ),
                ),

                SizedBox(height: 5),

                TextFieldEmail(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!isValidate(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  errorText: Text("enter valid email"),
                ),

                SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: AppTextStyle.headerStyle(20, FontWeight.w500),
                  ),
                ),

                SizedBox(height: 5),

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

                SizedBox(height: 20),

                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (image != null) {
                              final newUser = SimpleUser(
                                email: emailController.text,
                                password: passwordController.text,
                                userId: "#12345",
                                imagePath: image!
                                    .path, // Store the path instead of File object
                              );
                              SignUpController.addUser(newUser);
                              // Update auth provider state with the new user
                              ref.read(authProvider.notifier).state = newUser;
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select an image')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          backgroundColor: AppColors.secondary,
                        ),
                        child: Text(
                          "SignUp",
                          style: AppTextStyle.headerStyle(20, FontWeight.w500),
                        ),
                      ),
                    );
                  },

                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account? ",
                      style: AppTextStyle.headerStyle(14, FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResponsiveLayoutW(mobileBody: Login(), desktopBody: LoginWeb())),
                        );
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyle.headerStyle(14, FontWeight.w400),
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      LoggingDetail.isGuest = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveLayoutW(mobileBody: Dashboard(), desktopBody: DashboardWeb()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      minimumSize: Size(300, 50),
                    ),
                    child: Text(
                      "Login as Guest",
                      style: AppTextStyle.headerStyle(20, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
