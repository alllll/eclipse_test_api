import 'package:eclipse_test_api/data/repositories/album_repository.dart';
import 'package:eclipse_test_api/data/repositories/photo_repository.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class AlbumsController extends GetxController {
  final albumRepository = Get.find<AlbumRepository>();
  final photoRepository = Get.find<PhotoRepository>();
  RxList<AlbumPreview> albumsPreviews =
      RxList<AlbumPreview>(List.empty(growable: true));

  AlbumsController() {
    fetchAlbums(Get.arguments["id"]);
  }

  void fetchAlbums(int userId) async {
    albumsPreviews.clear();
    try {
      var albums = (await albumRepository.fetchAlbums(userId));
      Future.forEach(albums, (Album element) async {
        try {
          final photos = await photoRepository.fetchPhotos(element.id);
          albumsPreviews.add(AlbumPreview(album: element, photo: photos));
        } catch (err) {
          return;
        }
      });
    } catch (err) {
      return;
    }
  }
}
