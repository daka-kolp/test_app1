import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app1/src/data/repositories/post_repo_impl.dart';
import 'package:test_app1/src/domain/repositories/post_repo.dart';
import 'package:test_app1/src/ui/screens/posts_screen/cubits/posts_cubit.dart';
import 'package:test_app1/src/ui/screens/posts_screen/posts_screen.dart';

void main() {
  GetIt.I
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<PostRepo>(PostRepoImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsCubit>(create: (context) => PostsCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostsScreen(),
      ),
    );
  }
}
