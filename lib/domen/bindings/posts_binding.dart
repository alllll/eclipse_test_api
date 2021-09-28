import 'package:eclipse_test_api/domen/controllers/posts_controller.dart';
import 'package:get/get.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostsController());
  }
}
