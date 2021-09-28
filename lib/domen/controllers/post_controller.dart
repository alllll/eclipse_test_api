import 'package:eclipse_test_api/data/repositories/comment_repository.dart';
import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final postRepository = Get.find<PostRepository>();
  final commentRepository = Get.find<CommentRepository>();

  late Rx<Post?> post;
  RxList<Comment> comments = RxList.empty(growable: true);

  PostController() {
    post = Rx<Post?>(null);
    fetchPost(Get.arguments["id"]).then((value) {
      fetchComments(post.value!.id);
    });
  }

  Future<void> fetchPost(int id) async {
    try {
      post.value = await postRepository.fetchPost(id);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      comments.value = await commentRepository.fetchComments(postId);
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
  }

  Future<bool> sendComment(Comment newComment) async {
    try {
      final comment = await commentRepository.sendComment(newComment);
      comments.add(comment);
      return true;
    } catch (err) {
      Get.snackbar("Error", "Trying later ...");
    }
    return false;
  }
}
