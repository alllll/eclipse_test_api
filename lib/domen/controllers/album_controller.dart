import 'package:eclipse_test_api/data/repositories/album_repository.dart';
import 'package:eclipse_test_api/data/repositories/photo_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final albumRepository = Get.find<AlbumRepository>();
  final photoRepository = Get.find<PhotoRepository>();

  late Rx<Album> album;
  RxList<Photo> photos = RxList<Photo>(List.empty());

  AlbumController() {
    fetchAlbum(Get.arguments["id"]);
  }

  void fetchAlbum(int id) async {
    try {
      album = Rx<Album>(await albumRepository.fetchAlbum(id));
      photos.value = await photoRepository.fetchPhotos(album.value.id);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }
}
