import 'package:eclipse_test_api/domen/controllers/post_controller.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[100],
          elevation: 0,
          title: const Text("Пост"),
        ),
        body: SafeArea(child: Obx(() {
          if (controller.post.value != null) {
            return RefreshIndicator(
              onRefresh: () async => controller.refreshScreen(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _PostCard(post: controller.post.value!),
                          const Divider(),
                          const Text("Комментарии"),
                          _CommentList(comments: controller.comments.value),
                          Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  await Get.dialog(
                                    Scaffold(
                                      body: _CreateComment(),
                                    ),
                                  );
                                },
                                child: const Text("Оставить комментарий")),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })));
  }
}

class _CreateComment extends GetView<PostController> {
  _CreateComment({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerComment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width / 1.1,
        height: Get.height / 1.1,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: controllerName,
                    decoration: const InputDecoration(hintText: 'Имя'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Необходимо ввести ваши имя';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Необходимо ввести ваш email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Вы указали неправильный емейл';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: controllerComment,
                    decoration: const InputDecoration(hintText: 'Текст'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Необходимо ввести текст';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          controller
                              .sendComment(Comment(
                                  postId: controller.post.value!.id,
                                  id: 0,
                                  name: controllerName.text,
                                  email: controllerEmail.text,
                                  body: controllerComment.text))
                              .then((result) {
                            if (result) {
                              Get.back();
                            } else {
                              Get.snackbar(
                                  "Ошибка", "Комментарий не отправлен");
                            }
                          });
                        }
                      },
                      child: const Text("Отправить")),
                  ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text("Отмена")),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

class _PostCard extends StatelessWidget {
  const _PostCard({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(post.body)
          ],
        ),
      ),
    );
  }
}

class _CommentList extends StatelessWidget {
  const _CommentList({Key? key, required this.comments}) : super(key: key);
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comments[index].name,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  comments[index].email,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  comments[index].body,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: comments.length,
    );
  }
}
