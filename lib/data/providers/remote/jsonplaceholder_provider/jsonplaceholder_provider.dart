import 'package:dio/dio.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/comment.dart';
import 'package:eclipse_test_api/models/photo.dart';
import 'package:eclipse_test_api/models/album.dart';
import 'package:eclipse_test_api/models/user.dart';
import 'package:eclipse_test_api/models/post.dart';

class JsonPlaceholderProvider implements RemoteDataInterface {
  JsonPlaceholderProvider({required this.baseUrl}) {
    client =
        Dio(BaseOptions(baseUrl: baseUrl, responseType: ResponseType.plain));
  }

  String baseUrl;
  late final Dio client;

  @override
  Future<Album> fetchAlbum(int id) async {
    final response = await client.get("/album/$id");
    return Album.fromJson(response.data);
  }

  @override
  Future<List<Album>> fetchAlbums({int? userId}) async {
    if (userId != null) {
      final response =
          await client.get("/albums", queryParameters: {"userId": userId});
      return parseAlbums(response.data);
    } else {
      final response = await client.get("/albums");
      return parseAlbums(response.data);
    }
  }

  @override
  Future<Photo> fetchPhoto(int id) async {
    final response = await client.get("/photos/$id");
    return Photo.fromJson(response.data);
  }

  @override
  Future<List<Photo>> fetchPhotos({int? albumId}) async {
    if (albumId != null) {
      final response =
          await client.get("/photos", queryParameters: {"albumId": albumId});
      return parsePhotos(response.data);
    } else {
      final response = await client.get("/photos");
      return parsePhotos(response.data);
    }
  }

  @override
  Future<Post> fetchPost(int id) async {
    final response = await client.get("/posts/$id");
    return Post.fromJson(response.data);
  }

  @override
  Future<List<Post>> fetchPosts({int? userId}) async {
    if (userId != null) {
      final response =
          await client.get("/posts", queryParameters: {"userId": userId});
      return parsePost(response.data);
    } else {
      final response = await client.get("/posts");
      return parsePost(response.data);
    }
  }

  @override
  Future<List<User>> fetchUsers() async {
    final response = await client.get("/users");
    return parseUsers(response.data);
  }

  @override
  Future<User> fetchUser(int id) async {
    final response = await client.get("users/$id");
    return User.fromJson(response.data);
  }

  @override
  Future<Comment> fetchComment(int id) async {
    final response = await client.get("comments/$id");
    return Comment.fromJson(response.data);
  }

  @override
  Future<List<Comment>> fetchComments({int? postId}) async {
    if (postId != null) {
      final response =
          await client.get("/comments", queryParameters: {"postId": postId});
      return parseComment(response.data);
    } else {
      final response = await client.get("/comments");
      return parseComment(response.data);
    }
  }

  @override
  Future<Comment> sendComment(Comment comment) async {
    final response = await client.post("/comments", data: comment.toJson());
    return Comment.fromJson(response.data);
  }
}
