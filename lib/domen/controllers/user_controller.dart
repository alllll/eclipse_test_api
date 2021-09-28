import 'package:eclipse_test_api/data/repositories/album_repository.dart';
import 'package:eclipse_test_api/data/repositories/photo_repository.dart';
import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  final postRepository = Get.find<PostRepository>();
  final albumRepository = Get.find<AlbumRepository>();
  final photoRepository = Get.find<PhotoRepository>();

  Rx<User?> user = Rx<User?>(null);
  Rx<List<Post>> posts = Rx<List<Post>>(List.empty());
  // Rx<List<Album>> albums = Rx<List<Album>>(List.empty());
  /* Rx<List<AlbumPreview>> albumsPreviews =
      Rx<List<AlbumPreview>>(List.empty(growable: true));*/
  RxList<AlbumPreview> albumsPreviews =
      RxList<AlbumPreview>(List.empty(growable: true));

  UserController() {
    fetchUser(Get.arguments["id"]).then((value) {
      fetchPosts();
      fetchAlbums();
    });
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

  void fetchAlbums() async {
    try {
      var albums =
          (await albumRepository.fetchAlbums(user.value!.id)).sublist(0, 3);
      Future.forEach(albums, (Album element) async {
        final photos = await photoRepository.fetchPhotos(element.id);
        albumsPreviews.add(AlbumPreview(album: element, photo: photos));
      });
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }
}

class AlbumPreview {
  final Album album;
  final List<Photo> photo;

  AlbumPreview({required this.album, required this.photo});
}
