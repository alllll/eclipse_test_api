import 'package:eclipse_test_api/domen/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        if (controller.users.isNotEmpty) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed("/user",
                        arguments: {"id": controller.users[index].id});
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${controller.users[index].name}"),
                          Text("Username: ${controller.users[index].username}")
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.users.length);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      })),
    );
  }
}
