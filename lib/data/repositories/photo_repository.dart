import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PhotoRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();
  final connectivity = Connectivity();

  Future<List<Photo>> fetchPhotos(int albumId) async {
    late List<Photo> photos;
    try {
      photos = await localDataInterface.getPhotos(albumId: albumId);
      if (photos.isEmpty) {
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          photos = await remoteDataInterface.fetchPhotos(albumId: albumId);
          await localDataInterface.savePhotos(photos);
        } else {
          throw Exception("No internet connection");
        }
      }
    } catch (err) {
      photos = await localDataInterface.getPhotos(albumId: albumId);
      rethrow;
    }
    return photos;
  }

  Future<Photo> fetchPhoto(int id) async {
    var photo = await localDataInterface.getPhoto(id);
    photo ??= await remoteDataInterface.fetchPhoto(id);
    return photo;
  }
}
