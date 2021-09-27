import 'package:eclipse_test_api/models/index.dart';

abstract class LocalDataInterface {
  //users
  Future<void> saveUsers(List<User> users);
  Future<List<User>> getUsers();
  Future<User?> getUser(int id);
  Future<void> saveUser(User user);

  //posts
  Future<void> savePosts(List<Post> posts);
  Future<List<Post>> getPosts();
  Future<Post?> getPost(int id);
  Future<void> savePost(Post post);
}
