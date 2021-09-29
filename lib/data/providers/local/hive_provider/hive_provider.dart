import 'dart:async';

import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/models/photo.dart';
import 'package:eclipse_test_api/models/comment.dart';
import 'package:eclipse_test_api/models/album.dart';
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
  final Box albums = Get.find<Box>(tag: albumBox);
  final Box photos = Get.find<Box>(tag: photoBox);
  final Box comments = Get.find<Box>(tag: commentBox);

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
  Future<List<Post>> getPosts({int? userId}) {
    final compleater = Completer<List<Post>>();
    if (userId != null) {
      compleater.complete(posts.values
          .map((e) => e as Post)
          .where((post) => post.userId == userId)
          .toList());
    } else {
      compleater.complete(comments.values.map((e) => e as Post).toList());
    }
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

  @override
  Future<Album?> getAlbum(int id) {
    final compleater = Completer<Album?>();
    compleater.complete(albums.get(id));
    return compleater.future;
  }

  @override
  Future<List<Album>> getAlbums({int? userId}) {
    final compleater = Completer<List<Album>>();
    if (userId != null) {
      compleater.complete(albums.values
          .map((e) => e as Album)
          .where((album) => album.userId == userId)
          .toList());
    } else {
      compleater.complete(albums.values.map((e) => e as Album).toList());
    }
    return compleater.future;
  }

  @override
  Future<void> saveAlbum(Album album) async {
    await albums.put(album.id, album);
  }

  @override
  Future<void> saveAlbums(List<Album> newAlbums) async {
    for (var album in newAlbums) {
      albums.put(album.id, album);
    }
  }

  @override
  Future<Comment?> getComment(int id) {
    final compleater = Completer<Comment?>();
    compleater.complete(comments.get(id));
    return compleater.future;
  }

  @override
  Future<List<Comment>> getComments({int? postId}) {
    final compleater = Completer<List<Comment>>();
    if (postId != null) {
      compleater.complete(comments.values
          .map((e) => e as Comment)
          .where((comment) => comment.postId == postId)
          .toList());
    } else {
      compleater.complete(comments.values.map((e) => e as Comment).toList());
    }
    return compleater.future;
  }

  @override
  Future<void> saveComment(Comment comment) async {
    await comments.put(comment.id, comment);
  }

  @override
  Future<void> saveComments(List<Comment> newComments) async {
    for (var comment in newComments) {
      comments.put(comment.id, comment);
    }
  }

  @override
  Future<Photo?> getPhoto(int id) {
    final compleater = Completer<Photo?>();
    compleater.complete(photos.get(id));
    return compleater.future;
  }

  @override
  Future<List<Photo>> getPhotos({int? albumId}) {
    final compleater = Completer<List<Photo>>();
    if (albumId != null) {
      compleater.complete(photos.values
          .map((e) => e as Photo)
          .where((photo) => photo.albumId == albumId)
          .toList());
    } else {
      compleater.complete(photos.values.map((e) => e as Photo).toList());
    }
    return compleater.future;
  }

  @override
  Future<void> savePhoto(Photo photo) async {
    await photos.put(photo.id, photo);
  }

  @override
  Future<void> savePhotos(List<Photo> newPhotos) async {
    for (var photo in newPhotos) {
      photos.put(photo.id, photo);
    }
  }
}
