import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  late RxList<User> users;

  HomeController() {
    users = RxList.empty(growable: true);
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      users.value = await userRepository.fetchUsers();
    } catch (err) {
      print(err.toString());
      Get.snackbar("Error", "Trying later ...");
    }
  }
}
