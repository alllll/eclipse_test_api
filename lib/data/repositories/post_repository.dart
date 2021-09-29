import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PostRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();
  final connectivity = Connectivity();

  Future<List<Post>> fetchPosts(int userId) async {
    late List<Post> posts;
    try {
      posts = await localDataInterface.getPosts(userId: userId);
      if (posts.isEmpty) {
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          posts = await remoteDataInterface.fetchPosts(userId: userId);
          await localDataInterface.savePosts(posts);
        }
      }
    } catch (err) {
      posts = await localDataInterface.getPosts(userId: userId);
      rethrow;
    }
    return posts;
  }

  Future<Post> fetchPost(int id) async {
    var post = await localDataInterface.getPost(id);
    post ??= await remoteDataInterface.fetchPost(id);
    return post;
  }
}
