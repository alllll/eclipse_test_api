import 'package:eclipse_test_api/domen/controllers/post_controller.dart';
import 'package:get/get.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
