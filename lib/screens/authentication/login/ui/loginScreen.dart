// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/authentication/authWidgets/custom_button.dart';
import 'package:hello_dish_app/screens/authentication/authWidgets/custom_text__field.dart';
import 'package:hello_dish_app/screens/authentication/forgotPassword/ui/forgotPasswordScreen.dart';
import 'package:hello_dish_app/screens/authentication/login/controller/loginController.dart';
import 'package:hello_dish_app/screens/authentication/signup/ui/signUpScreen.dart';
import 'package:hello_dish_app/screens/home/dashboard_screen.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  IconData _icon = Icons.visibility_off;
  final LoginController loginContr = Get.put(LoginController());

  @override
  void dispose() {
    loginContr.emailController.dispose();
    loginContr.passwordController.dispose();
    super.dispose();
  }

  String _dropDownValue = 'English (India)';
  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return GetBuilder<LoginController>(
        builder: (c) => Scaffold(
              backgroundColor: const Color(0xffF8F9FD),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    Center(
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        underline: Container(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          _dropDownValue,
                          style: th.bodyMedium?.copyWith(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w600),
                        ),
                        items: <String>[
                          'English (India)',
                          'Hindi',
                          'French',
                          'Urdu'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: th.bodyMedium?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val!;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Welcome back!',
                          style: th.bodyLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Image.asset(
                          'assets/images/loginIcon.png',
                          height: 130,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Phone or mail ',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 60,
                      child: Center(
                        child: DCustomTextField(
                          controller: loginContr.emailController,
                          labelText: '',
                          // prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                          onTap: () {}, hintText: 'Enter your phone or email',
                        ),
                      ),
                    ),
                    Text(
                      'Password ',
                      style: th.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      height: 60,
                      child: Center(
                        child: DCustomTextField(
                          obscureText: !loginContr.isVisible.value,
                          suffixIcon: _icon,
                          controller: loginContr.passwordController,
                          keyboardType: TextInputType.name,
                          onTap: () {},
                          hintText: 'Enter your password',
                          onIconTap: () {
                            setState(() {
                              loginContr.isVisible.value =
                                  !loginContr.isVisible.value;
                              _icon = loginContr.isVisible.value
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
                    InkWell(
                      onTap: () {
                        Get.to(const ForgotPasswordScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',
                            style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomRoundedElevatedButton(
                      text: 'Log In',
                      onPressed: () {
                        loginContr.loginFunction();
                        // Get.offAll(const DashboardScreen());
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 30,
                        ),
                        Icon(
                          Icons.g_mobiledata_outlined,
                          size: 45,
                        ),
                        // Icon(
                        //   Icons.facebook,
                        //   size: 30,
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue as a Guest',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(DashboardScreen());
                          },
                          child: Text(
                            'Guest ',
                            style: th.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appThemeColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(const SignUpScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: th.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appThemeColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'By clicking, you agree to our',
                      style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Terms of sevice',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'Privacy Policy',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'Content Policy',
                          style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
