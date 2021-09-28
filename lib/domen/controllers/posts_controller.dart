import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  final postRepository = Get.find<PostRepository>();
  late RxList<Post> posts;

  PostsController() {
    posts = RxList.empty(growable: true);
    fetchPosts(Get.arguments["id"]);
  }

  void fetchPosts(int userId) async {
    try {
      posts.value = await postRepository.fetchPosts(userId);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }
}
