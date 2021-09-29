import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PostRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();

  Future<List<Post>> fetchPosts(int userId) async {
    late List<Post> posts;
    try {
      posts = await localDataInterface.getPosts(userId: userId);
      if (posts.isEmpty) {
        posts = await remoteDataInterface.fetchPosts(userId: userId);
        await localDataInterface.savePosts(posts);
      } else {
        print("posts from cache");
      }
    } catch (err) {
      print("posts from cache");
      posts = await localDataInterface.getPosts(userId: userId);
      rethrow;
    }
    return posts;
  }

  Future<Post> fetchPost(int id) async {
    var post = await localDataInterface.getPost(id);
    if (post != null) print("Post from cache!");
    post ??= await remoteDataInterface.fetchPost(id);
    return post;
  }
}
