import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class CommentRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();

  Future<List<Comment>> fetchComments(int postId) async {
    late List<Comment> comments;
    try {
      comments = await localDataInterface.getComments(postId: postId);
      if (comments.isEmpty) {
        comments = await remoteDataInterface.fetchComments(postId: postId);
        await localDataInterface.saveComments(comments);
      } else {
        print("comments from cache");
      }
    } catch (err) {
      print("comments from cache");
      comments = await localDataInterface.getComments(postId: postId);
    }
    return comments;
  }

  Future<Comment> fetchComment(int id) async {
    var comment = await localDataInterface.getComment(id);
    if (comment != null) print("Comment from cache!");
    comment ??= await remoteDataInterface.fetchComment(id);
    return comment;
  }

  Future<Comment> sendComment(Comment comment) async {
    final result = await remoteDataInterface.sendComment(comment);
    localDataInterface.saveComment(result);
    return result;
  }
}
