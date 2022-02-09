import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app1/src/domain/entities/post.dart';
import 'package:test_app1/src/domain/repositories/post_repo.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostRepo repo;

  PostsCubit()
      : repo = GetIt.I.get<PostRepo>(),
        super(PostsInitial()) {
    getPosts();
  }

  Future<void> getPosts() async {
    emit(PostsLoadInProgress());
    try {
      final posts = await repo.getPosts();
      emit(PostsFetched(posts));
    } catch (e) {
      emit(PostsLoadFailure('Unknown error: $e'));
    }
  }
}

abstract class PostsState extends Equatable {
  List<Object> get props => [];
}

class PostsInitial extends PostsState {
  PostsInitial();
}

class PostsFetched extends PostsState {
  final List<Post> posts;

  PostsFetched(this.posts);

  List<Object> get props => [posts];
}

class PostsLoadInProgress extends PostsState {
  PostsLoadInProgress();
}

class PostsLoadFailure extends PostsState {
  final String error;

  PostsLoadFailure(this.error);

  List<Object> get props => [error];
}