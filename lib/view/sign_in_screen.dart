import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/routes/app_routes.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';
import 'package:flutter_supabase_database/controller/auth_controller.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(body: _buildBody),
    );
  }

  get _buildBody {
    List icon = [
      Icons.facebook,
      Icons.apple,
      Icons.telegram,
      Icons.mail_rounded,
    ];
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        image: DecorationImage(
          image: AssetImage('assets/image/background_1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Container(
                  height: Get.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      spacing: 28,
                      children: [
                        SizedBox(),
                        Stack(
                          children: [
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                foreground:
                                    Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: controller.emailCtrl,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: controller.passCtrl,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Obx(
                        //       () => Checkbox(
                        //         value: controller.getIsChecked,
                        //         onChanged: controller.setIsChecked,
                        //       ),
                        //     ),
                        //     RichText(
                        //       text: TextSpan(
                        //         text: 'I agree to the processing of ',
                        //         style: TextStyle(color: Colors.black),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //             text: 'Personal data',
                        //             style: TextStyle(
                        //               color: AppTheme.primaryColor,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Obx(
                          () => SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.signIn(
                                  controller.emailCtrl.text,
                                  controller.passCtrl.text,
                                );
                              },
                              child:
                                  controller.loading.value
                                      ? SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                      : Text(
                                        'Sign in',
                                        style: TextStyle(color: Colors.white),
                                      ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Sign up with',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(icon.length, (index) {
                            return IconButton(
                              icon: Icon(
                                icon[index],
                                color: AppTheme.primaryColor,
                                size: 38,
                              ),
                              onPressed: () {},
                            );
                          }),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(AppRoutes.auth);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
