import 'package:eclipse_test_api/domen/controllers/albums_controller.dart';
import 'package:get/get.dart';

class AlbumsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AlbumsController());
  }
}
