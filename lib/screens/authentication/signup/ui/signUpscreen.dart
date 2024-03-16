// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/authentication/authWidgets/custom_button.dart';
import 'package:hello_dish_app/screens/authentication/authWidgets/custom_text__field.dart';
import 'package:hello_dish_app/screens/authentication/login/ui/loginScreen.dart';
import 'package:hello_dish_app/screens/authentication/signup/controller/signUpController.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  IconData _icon = Icons.visibility_off;
  IconData _icon1 = Icons.visibility_off;
  final SignupController signUpContr = Get.put(SignupController());

  @override
  void dispose() {
    signUpContr.emailController.dispose();
    signUpContr.passwordController.dispose();
    signUpContr.nameController.dispose();
    signUpContr.numberController.dispose();
    signUpContr.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return GetBuilder<SignupController>(
        builder: (c) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      Get.offAll(const LoginScreen());
                    },
                    child: const Icon(Icons.arrow_back_ios)),
              ),
              backgroundColor: const Color(0xffF8F9FD),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/JOIN.png',
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/images/HELLO DISH (1).png',
                          height: 60,
                          width: 190,
                        ),
                      ],
                    ),
                    Text(
                      'Create a new account and unlock a \ncreative world. Sign Up Now!',
                      style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Full Name ',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: DCustomTextField(
                          controller: signUpContr.nameController,
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                          onTap: () {},
                          hintText: 'Joe Smith',
                        ),
                      ),
                    ),
                    Text(
                      'Email Address',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: DCustomTextField(
                          controller: signUpContr.emailController,
                          prefixIcon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onTap: () {},
                          hintText: 'example@gmail.com',
                        ),
                      ),
                    ),
                    Text(
                      'Number',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: DCustomTextField(
                          controller: signUpContr.numberController,
                          labelText: '+91 955555566',
                          keyboardType: TextInputType.number,
                          onTap: () {},
                          hintText: '+91 955555566',
                        ),
                      ),
                    ),
                    Text(
                      'Password ',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: DCustomTextField(
                          obscureText: !signUpContr.isVisible.value,
                          suffixIcon: _icon,
                          controller: signUpContr.passwordController,
                          prefixIcon: Icons.lock_outlined,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onTap: () {},
                          hintText: 'Enter your password',
                          onIconTap: () {
                            setState(() {
                              signUpContr.isVisible.value =
                                  !signUpContr.isVisible.value;
                              _icon = signUpContr.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      'Confirm Password ',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: DCustomTextField(
                          obscureText: !signUpContr.isVisible.value,
                          suffixIcon: _icon1,
                          controller: signUpContr.confirmPasswordController,
                          prefixIcon: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          hintText: 'Confirm your Password',
                          onIconTap: () {
                            setState(() {
                              signUpContr.isVisible.value =
                                  !signUpContr.isVisible.value;
                              _icon1 = signUpContr.isVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRoundedElevatedButton(
                      text: 'Sign Up',
                      onPressed: () {
                        signUpContr.signUpFunction();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(const LoginScreen());
                          },
                          child: Text(
                            'Sign In ',
                            style: th.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appThemeColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
