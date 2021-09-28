import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PhotoRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();

  Future<List<Photo>> fetchPhotos(int albumId) async {
    final photos = await remoteDataInterface.fetchPhotos(albumId: albumId);
    await localDataInterface.savePhotos(photos);
    return photos;
  }

  Future<Photo> fetchPhoto(int id) async {
    var photo = await localDataInterface.getPhoto(id);
    if (photo != null) print("Photo from cache!");
    photo ??= await remoteDataInterface.fetchPhoto(id);
    return photo;
  }
}
