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

  //albums
  Future<void> saveAlbums(List<Album> albums);
  Future<List<Album>> getAlbums();
  Future<Album?> getAlbum(int id);
  Future<void> saveAlbum(Album album);

  //photos
  Future<void> savePhotos(List<Photo> photos);
  Future<List<Photo>> getPhotos();
  Future<Photo?> getPhoto(int id);
  Future<void> savePhoto(Photo photo);

  //comments
  Future<void> saveComments(List<Comment> comments);
  Future<List<Comment>> getComments();
  Future<Comment?> getComment(int id);
  Future<void> saveComment(Comment comment);
}
