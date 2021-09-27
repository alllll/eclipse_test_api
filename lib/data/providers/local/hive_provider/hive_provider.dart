import 'dart:async';

import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/models/post.dart';
import 'package:eclipse_test_api/models/user.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String userBox = "userBox";
const String albumBox = "albumBox";
const String commentBox = "commentBox";
const String photoBox = "photoBox";
const String postBox = "postBox";

class HiveProvider implements LocalDataInterface {
  final Box users = Get.find<Box>(tag: userBox);
  final Box posts = Get.find<Box>(tag: postBox);

  //users
  @override
  Future<User?> getUser(int id) {
    final compleater = Completer<User?>();
    compleater.complete(users.get(id));
    return compleater.future;
  }

  @override
  Future<List<User>> getUsers() {
    final compleater = Completer<List<User>>();
    compleater.complete(users.values.map((e) => e as User).toList());
    return compleater.future;
  }

  @override
  Future<void> saveUser(User user) async {
    await users.put(user.id, user);
  }

  @override
  Future<void> saveUsers(List<User> newUsers) async {
    for (var user in newUsers) {
      users.put(user.id, user);
    }
  }

  //posts
  @override
  Future<Post?> getPost(int id) {
    final compleater = Completer<Post?>();
    compleater.complete(posts.get(id));
    return compleater.future;
  }

  @override
  Future<List<Post>> getPosts() {
    final compleater = Completer<List<Post>>();
    compleater.complete(posts.values.map((e) => e as Post).toList());
    return compleater.future;
  }

  @override
  Future<void> savePost(Post post) async {
    await posts.put(post.id, post);
  }

  @override
  Future<void> savePosts(List<Post> newPosts) async {
    for (var post in newPosts) {
      posts.put(post.id, post);
    }
  }
}
