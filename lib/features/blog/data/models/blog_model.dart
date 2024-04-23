// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../domain/entities/blog.dart';

// part 'blog_model.freezed.dart';
// part 'blog_model.g.dart';

// @Freezed(unionValueCase: FreezedUnionCase.snake)
// class BlogModel extends Blog with _$BlogModel {
//   factory BlogModel({
//     required String id,
//     @JsonKey(name: 'poster_id') required String posterId,
//     required String title,
//     required String content,
//     @JsonKey(name: 'image_url') required String imageUrl,
//     required List<String> topics,
//     @JsonKey(name: 'updated_at') required DateTime updatedAt,
//     String? posterName,
//   }) = _BlogModel;

//   factory BlogModel.fromJson(Map<String, Object?> json) =>
//       _$BlogModelFromJson(json);
// }

import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      posterId: json['poster_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      topics: List<String>.from(json['topics'] ?? []),
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at']),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
