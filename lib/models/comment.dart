import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'comment.g.dart';

@HiveType(typeId: 7)
@immutable
class Comment {
  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  @HiveField(0)
  final int postId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String);

  Map<String, dynamic> toJson() =>
      {'postId': postId, 'id': id, 'name': name, 'email': email, 'body': body};

  Comment clone() =>
      Comment(postId: postId, id: id, name: name, email: email, body: body);

  Comment copyWith(
          {int? postId, int? id, String? name, String? email, String? body}) =>
      Comment(
        postId: postId ?? this.postId,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          postId == other.postId &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          body == other.body;

  @override
  int get hashCode =>
      postId.hashCode ^
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      body.hashCode;
}

List<Comment> parseComment(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
}
