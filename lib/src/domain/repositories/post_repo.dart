import 'package:test_app1/src/domain/entities/comment.dart';
import 'package:test_app1/src/domain/entities/post.dart';

abstract class PostRepo {
  Future<List<Post>> getPosts();

  Future<List<Comment>> getComments(int postId);
}
