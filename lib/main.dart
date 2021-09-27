import 'package:eclipse_test_api/domen/bindings/home_binding.dart';
import 'package:eclipse_test_api/domen/bindings/user_binding.dart';
import 'package:eclipse_test_api/init_app.dart';
import 'package:eclipse_test_api/ui/screens/home/home_screen.dart';
import 'package:eclipse_test_api/ui/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eclipse Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {}),
      getPages: [
        GetPage(
            name: "/", page: () => const HomeScreen(), binding: HomeBinding()),
        GetPage(
            name: "/user",
            page: () => const UserScreen(),
            binding: UserBinding())
      ],
    );
  }
}
