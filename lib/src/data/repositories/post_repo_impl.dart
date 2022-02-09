import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app1/src/data/models/comment_model.dart';
import 'package:test_app1/src/data/models/post_model.dart';
import 'package:test_app1/src/domain/entities/comment.dart';
import 'package:test_app1/src/domain/entities/post.dart';
import 'package:test_app1/src/domain/repositories/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final Dio _client;
  final _base = 'http://jsonplaceholder.typicode.com';

  PostRepoImpl() : _client = GetIt.I.get<Dio>();

  @override
  Future<List<Post>> getPosts() async {
    final response = await _client.get('$_base/posts');
    return response.data.map<Post>((e) => PostModel.fromJson(e).fromModel).toList();
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    final response = await _client.get('$_base/comments?postId=$postId');
    return response.data.map<Comment>((e) => CommentModel.fromJson(e).fromModel).toList();
  }
}