import 'package:json_annotation/json_annotation.dart';
import 'package:test_app1/src/domain/entities/comment.dart';

part 'comment_model.g.dart';

@JsonSerializable(createToJson: false)
class CommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;


  CommentModel(this.postId, this.id, this.name, this.email, this.body);

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Comment get fromModel {
    return Comment(id, email, body);
  }
}
