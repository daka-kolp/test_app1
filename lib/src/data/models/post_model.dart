import 'package:json_annotation/json_annotation.dart';
import 'package:test_app1/src/domain/entities/post.dart';

part 'post_model.g.dart';

@JsonSerializable(createToJson: false)
class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel(this.id, this.userId, this.title, this.body);

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Post get fromModel {
    return Post(id, userId, title, body);
  }
}
