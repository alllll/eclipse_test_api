import 'package:eclipse_test_api/domen/controllers/album_controller.dart';
import 'package:get/get.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AlbumController());
  }
}
