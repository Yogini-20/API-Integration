
import 'package:api_integration/features/forgot_password/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateView extends GetView<UpdateController> {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              const Text("Please enter email-id to reset password"),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                validator: (value) {
                  return controller.validateEmail(value!);
                },
              ),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    onPressed: () async {
                      final isValid = controller.formKey.currentState!.validate();
                      if (isValid) {
                        Get.defaultDialog(
                            title: "Reset Password",
                            barrierDismissible: true,
                            content: Form(
                                key: controller.resKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextFormField(
                                      controller: controller.passwordController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.password),
                                          hintText: 'Enter password',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green))),
                                      validator: (value) {
                                        return controller
                                            .validatePassword(value!);
                                      },
                                    ),
                                    TextFormField(
                                      controller:
                                          controller.confirmPasswordController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.password),
                                          hintText: 'Confirm password',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green))),
                                      validator: (value) {
                                        return controller
                                            .validatePassword(value!);
                                      },
                                    ),
                                    SizedBox(
                                      width: 350,
                                      child: ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.green),
                                          ),
                                          onPressed: () async {
                                            final isValid = controller
                                                .resKey.currentState!
                                                .validate();
                                            if (isValid) {
                                              if (controller
                                                      .confirmPasswordController
                                                      .value ==
                                                  controller
                                                      .passwordController.value) {
                                                controller.forgot();
                                              } else {
                                                Get.snackbar("title",
                                                    "Enter same password");
                                              }
                                            } else {
                                              Get.snackbar(
                                                  "'Please fill input'", "");
                                            }
                                          },
                                          child: const Text('Reset Password')),
                                    ),
                                  ],
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')));
                      }
                    },
                    child: const Text('Reset Password')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
