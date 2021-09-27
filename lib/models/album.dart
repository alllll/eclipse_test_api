import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'album.g.dart';

@HiveType(typeId: 8)
@immutable
class Album {
  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String);

  Map<String, dynamic> toJson() => {'userId': userId, 'id': id, 'title': title};

  Album clone() => Album(userId: userId, id: id, title: title);

  Album copyWith({int? userId, int? id, String? title}) => Album(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          userId == other.userId &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode;
}
