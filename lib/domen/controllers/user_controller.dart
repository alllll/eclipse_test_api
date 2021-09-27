import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  final postRepository = Get.find<PostRepository>();

  Rx<User?> user = Rx<User?>(null);
  Rx<List<Post>> posts = Rx<List<Post>>(List.empty());

  UserController() {
    fetchUser(Get.arguments["id"]).then((value) => fetchPosts());
  }

  Future<void> fetchUser(int id) async {
    try {
      user.value = await userRepository.fetchUser(id);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }

  void fetchPosts() async {
    try {
      posts.value =
          (await postRepository.fetchPosts(user.value!.id)).sublist(0, 3);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }
}
