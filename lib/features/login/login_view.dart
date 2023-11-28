
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';

import '../../constant/routes.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: const Color(0xFF4CAF50),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: Form(
              key: controller.key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter UserId',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green
                            )
                          )
                      ),
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                    ),
                    Obx(() => TextFormField(
                      controller: controller.passController,
                      obscureText: controller.passToggle.value,
                      decoration:InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        hintText: 'Enter Password',
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green
                            )
                        ),
                        suffixIcon:IconButton(
                            icon:controller.passToggle.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            onPressed:(){
                              controller.passToggle.value =!controller.passToggle.value;
                            },
                        )
                      ),
                      validator: (value) {
                        return controller.validatePassword(value!);
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.toNamed(RoutesConstant.updatePage);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green),
                          ),
                          onPressed: () async {

                            final isValid = controller.key.currentState!.validate();
                            if (isValid) {
                              controller.login();
                              Get.offAllNamed(RoutesConstant.dashboardPage);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')));
                            }
                          },
                          child: const Text('Log in')),
                    ),
                    SizedBox(
                      width: 350,
                      child: SignInButton(
                        Buttons.Google,
                        text: "Log in with Google",
                        onPressed: () async {
                          controller.checkConnected();
                          // controller.loginWithGoogle();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do not have an account?',
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(RoutesConstant.signupPage);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.orange),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
