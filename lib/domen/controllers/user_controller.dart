import 'dart:async';

import 'package:eclipse_test_api/data/repositories/album_repository.dart';
import 'package:eclipse_test_api/data/repositories/photo_repository.dart';
import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  final postRepository = Get.find<PostRepository>();
  final albumRepository = Get.find<AlbumRepository>();
  final photoRepository = Get.find<PhotoRepository>();

  Rx<User?> user = Rx<User?>(null);
  RxList<Post> posts = RxList<Post>(List.empty());
  RxList<AlbumPreview> albumsPreviews =
      RxList<AlbumPreview>(List.empty(growable: true));

  UserController() {
    refreshScreen();
  }

  Future<void> fetchUser(int id) async {
    try {
      user.value = await userRepository.fetchUser(id);
    } catch (err) {
      return;
    }
  }

  void fetchPosts() async {
    try {
      posts.value =
          (await postRepository.fetchPosts(user.value!.id)).sublist(0, 3);
    } catch (err) {
      return;
    }
  }

  void fetchAlbums() async {
    albumsPreviews.clear();
    try {
      var albums =
          (await albumRepository.fetchAlbums(user.value!.id)).sublist(0, 3);
      Future.forEach(albums, (Album element) async {
        final photos = await photoRepository.fetchPhotos(element.id);
        albumsPreviews.add(AlbumPreview(album: element, photo: photos));
      });
    } catch (err) {
      return;
    }
  }

  void refreshScreen() async {
    fetchUser(Get.arguments["id"]).then((value) {
      fetchPosts();
      fetchAlbums();
    });
  }
}
