import 'package:eclipse_test_api/domen/controllers/posts_controller.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PostsScreen extends GetView<PostsController> {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        title: const Text("Все посты"),
      ),
      body: SafeArea(child: Obx(() {
        if (controller.posts.isNotEmpty) {
          return _Posts(posts: controller.posts);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      })),
    );
  }
}

class _Posts extends StatelessWidget {
  const _Posts({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Get.toNamed("/post", arguments: {"id": posts[index].id}),
          child: Card(
            margin: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    posts[index].body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: posts.length,
    );
  }
}
