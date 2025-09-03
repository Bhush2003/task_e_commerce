import 'dart:io';

import 'package:e_commerce_responsive/framework/repository/auth/model/user.dart';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../framework/controllers/auth/signup/signup_controller.dart';
import '../../../utils/consts/theam/app_text_style.dart';
import '../../helper/text_field_email.dart';
import '../../helper/text_fild_password.dart';
import '../login/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 80),
                Center(
                  child: Text(
                    "SignUp",
                    style: AppTextStyle.headerStyle(28, FontWeight.w900),
                  ),
                ),

                SizedBox(height: 30),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPicker(context: context);
                      });
                    },
                    child: CircleAvatar(
                      radius: 80,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (image != null) {
                          SignUpController.addUser(
                            User(
                              email: emailController.text,
                              password: passwordController.text,
                              userId: "#12345",
                              imagePath: image!
                                  .path, // Store the path instead of File object
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select an image')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 60),
                      backgroundColor: AppColors.secondary,
                    ),
                    child: Text(
                      "SignUp",
                      style: AppTextStyle.headerStyle(24, FontWeight.w500),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account? ",
                      style: AppTextStyle.headerStyle(16, FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyle.headerStyle(16, FontWeight.w400),
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      minimumSize: Size(300, 60),
                    ),
                    child: Text(
                      "Login as Guest",
                      style: AppTextStyle.headerStyle(24, FontWeight.w500),
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
