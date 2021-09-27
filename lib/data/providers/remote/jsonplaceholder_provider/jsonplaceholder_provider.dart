import 'package:dio/dio.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
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
  Future<Album> fetchAlbum(int id) {
    // TODO: implement fetchAlbum
    throw UnimplementedError();
  }

  @override
  Future<List<Album>> fetchAlbums({int? userId}) {
    // TODO: implement fetchAlbums
    throw UnimplementedError();
  }

  @override
  Future<Post> fetchPhoto(int id) {
    // TODO: implement fetchPhoto
    throw UnimplementedError();
  }

  @override
  Future<List<Photo>> fetchPhotos({int? albumId}) {
    // TODO: implement fetchPhotos
    throw UnimplementedError();
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
}
