import 'package:eclipse_test_api/models/index.dart';

abstract class RemoteDataInterface {
  //users
  Future<List<User>> fetchUsers();
  Future<User> fetchUser(int id);

  //posts
  Future<List<Post>> fetchPosts({int? userId});
  Future<Post> fetchPost(int id);

  //albums
  Future<List<Album>> fetchAlbums({int? userId});
  Future<Album> fetchAlbum(int id);

  //photos
  Future<List<Photo>> fetchPhotos({int? albumId});
  Future<Post> fetchPhoto(int id);
}
