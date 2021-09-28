import 'package:eclipse_test_api/domen/controllers/user_controller.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Obx(() {
            return Text(controller.user.value?.username ?? "");
          }),
        ),
        body: SafeArea(child: Obx(() {
          if (controller.user.value != null) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Профиль", style: TextStyle(fontSize: 20)),
                        _UserCard(user: controller.user.value!),
                        const Divider(),
                        const Text("Посты", style: TextStyle(fontSize: 20)),
                        _RecentPosts(posts: controller.posts.value),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/posts", arguments: {
                                  "id": controller.user.value!.id
                                });
                              },
                              child: const Text("Просмотреть все")),
                        ),
                        const Divider(),
                        const Text("Альбомы", style: TextStyle(fontSize: 20)),
                        _UserAlbums(albums: controller.albumsPreviews.value)
                      ],
                    ),
                  ]),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })));
  }
}

class _UserAlbums extends StatelessWidget {
  const _UserAlbums({Key? key, required this.albums}) : super(key: key);

  final List<AlbumPreview> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: albums.length + 1,
        itemBuilder: (BuildContext context, index) {
          if (albums.isEmpty) {
            return Container();
          } else {
            if (index >= albums.length) {
              return GestureDetector(
                onTap: () => Get.toNamed("/albums",
                    arguments: {"id": albums.first.album.userId}),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Просмотреть все"),
                          )
                        ]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () => Get.toNamed("/album",
                    arguments: {"id": albums[index].album.id}),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(albums[index].album.title),
                          )
                        ]),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                albums[index].photo[0].thumbnailUrl)),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              );
            }
          }
        });
  }
}

class _RecentPosts extends StatelessWidget {
  const _RecentPosts({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name}"),
            Text("Email: ${user.email}"),
            Text("Phone: ${user.phone}"),
            Text("Website: ${user.website}"),
            Text("Company: ${user.company.name}"),
            Text("BS: ${user.company.bs}"),
            Row(
              children: [
                const Text("Catch phrase:"),
                Text(user.company.catchPhrase,
                    style: const TextStyle(fontStyle: FontStyle.italic))
              ],
            ),
            Text(
                "Address: ${user.address.suite}, ${user.address.street}, ${user.address.city}, ${user.address.zipcode}"),
          ],
        ),
      ),
    );
  }
}
