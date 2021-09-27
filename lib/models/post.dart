import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 5)
@immutable
class Post {
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String);

  Map<String, dynamic> toJson() =>
      {'userId': userId, 'id': id, 'title': title, 'body': body};

  Post clone() => Post(userId: userId, id: id, title: title, body: body);

  Post copyWith({int? userId, int? id, String? title, String? body}) => Post(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          userId == other.userId &&
          id == other.id &&
          title == other.title &&
          body == other.body;

  @override
  int get hashCode =>
      userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
}

List<Post> parsePost(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
