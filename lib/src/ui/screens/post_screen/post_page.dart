import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app1/src/domain/entities/comment.dart';
import 'package:test_app1/src/domain/entities/post.dart';
import 'package:test_app1/src/ui/screens/post_screen/cubits/comments_cubit.dart';

class PostPage extends StatelessWidget {
  final Post post;

  const PostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: theme.textTheme.headline6),
                const Divider(),
                Text(post.body, style: theme.textTheme.subtitle1),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CommentsCubit, CommentsState>(
              builder: (context, state) {
                if (state is CommentsLoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CommentsFetched) {
                  final comments = state.comments;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, i) => _buildCommentTile(context, comments[i]),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(BuildContext context, Comment comment) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(comment.from, style: theme.textTheme.subtitle1),
            const Divider(),
            Text(comment.body),
          ],
        ),
      ),
    );
  }
}
