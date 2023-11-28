import 'package:api_integration/features/signup/signUp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

import '../../constant/routes.dart';

class SignupView extends GetView<SignupController> {
   const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
         backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SizedBox(
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.orgController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      hintText: 'Enter Organization Name',
                      enabledBorder: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter valid name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter User Name',
                      enabledBorder: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter valid Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.phoneController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Enter Phone number',
                      enabledBorder: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return controller.validateMobile(value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter Email Id',
                      enabledBorder: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.passToggle.value,
                    decoration:InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        hintText: 'Enter Password',
                        enabledBorder: const OutlineInputBorder(),
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
                ),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shadowColor: Colors.black),
                    onPressed:(){
                        final isValid = controller.formKey.currentState!.validate();
                        if (isValid) {
                          controller.signup();
                          controller.checkConnection();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill input')));
                        }
                      },
                      child: const Text("Sign Up")
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign Up with Google",
                    onPressed: () {

                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(RoutesConstant.loginPage);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.orange),
                        )),
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
