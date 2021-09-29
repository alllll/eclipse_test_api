import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/album.dart';
import 'package:get/get.dart';

class AlbumRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();

  Future<List<Album>> fetchAlbums(int userId) async {
    late List<Album> albums;
    try {
      albums = await localDataInterface.getAlbums(userId: userId);
      if (albums.isEmpty) {
        albums = await remoteDataInterface.fetchAlbums(userId: userId);
        await localDataInterface.saveAlbums(albums);
      } else {
        print("posts from cache");
      }
    } catch (err) {
      print("posts from cache");
      albums = await localDataInterface.getAlbums(userId: userId);
      rethrow;
    }
    return albums;
  }

  Future<Album> fetchAlbum(int id) async {
    var album = await localDataInterface.getAlbum(id);
    if (album != null) print("Album from cache!");
    album ??= await remoteDataInterface.fetchAlbum(id);
    return album;
  }
}
