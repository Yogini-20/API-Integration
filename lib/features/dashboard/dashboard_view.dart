import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/routes.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(controller.organisationName.value),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () async {
                Get.offAllNamed(RoutesConstant.profilePage);
              },
              icon: const Icon(Icons.person)
          ),
          IconButton(
              onPressed: () async {
                controller.logoutGoogle();
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLogIn", false);
                Get.offAllNamed(RoutesConstant.loginPage);
              },
              icon: const Icon(Icons.logout)
              )
          ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){}
      ),

      drawer: Drawer(
        child: ListView(
          children: const [DrawerHeader(child: null,)],
        ),
      ),
      body:Container(
        color: Colors.white60,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/OIP.KsXop6XHq4NfaZ2UwXWOPgAAAA?pid=ImgDet&rs=1'),
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    controller.names.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.green[600])),
                      onPressed:() {
                      },
                      child:controller.trigger!.value? const Text('Time in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ):const Text("Time Out"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    height: 10,
                    color: Colors.grey[350],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Obx(() => SizedBox(
                                    width: 250,
                                    child: Text(
                                      controller.address.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    controller.getPosition();
                                  },
                                  child: TextButton(
                                      onPressed: (){},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            color: Colors.green[600],
                                          ),
                                          Text('Refresh Location',style: TextStyle(color: Colors.green[600]),)
                                        ],
                                      )
                                  ),

                              ),
                            ],
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
      ),
    )
    );
  }
}
