import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app1/src/domain/entities/post.dart';
import 'package:test_app1/src/ui/screens/post_screen/cubits/comments_cubit.dart';
import 'package:test_app1/src/ui/screens/post_screen/post_page.dart';
import 'package:test_app1/src/ui/screens/posts_screen/cubits/posts_cubit.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: context.read<PostsCubit>().getPosts,
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsFetched) {
            final posts = state.posts;
            return ListView.separated(
              itemCount: posts.length,
              itemBuilder: (context, i) => _buildPostTile(context, posts[i]),
              separatorBuilder: (context, i) => const Divider(),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildPostTile(BuildContext context, Post post) {
    return ListTile(
      title: Text(post.title),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<CommentsCubit>(
              create: (context) => CommentsCubit(post.id),
              child: PostPage(post: post),
            ),
          ),
        );
      },
    );
  }
}
