import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class CommentRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();
  final connectivity = Connectivity();

  Future<List<Comment>> fetchComments(int postId) async {
    late List<Comment> comments;
    try {
      comments = await localDataInterface.getComments(postId: postId);
      if (comments.isEmpty) {
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          comments = await remoteDataInterface.fetchComments(postId: postId);
          await localDataInterface.saveComments(comments);
        }
      }
    } catch (err) {
      comments = await localDataInterface.getComments(postId: postId);
      rethrow;
    }
    return comments;
  }

  Future<Comment> fetchComment(int id) async {
    var comment = await localDataInterface.getComment(id);
    comment ??= await remoteDataInterface.fetchComment(id);
    return comment;
  }

  Future<Comment> sendComment(Comment comment) async {
    final Comment result;
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      result = await remoteDataInterface.sendComment(comment);
      localDataInterface.saveComment(result);
      return result;
    } else {
      throw Exception("Check connect");
    }
  }
}
