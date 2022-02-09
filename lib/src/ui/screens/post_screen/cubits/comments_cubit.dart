import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app1/src/domain/entities/comment.dart';
import 'package:test_app1/src/domain/repositories/post_repo.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PostRepo repo;
  final int postId;

  CommentsCubit(this.postId)
      : repo = GetIt.I.get<PostRepo>(),
        super(CommentsInitial()) {
    getComments(postId);
  }

  Future<void> getComments(int postId) async {
    emit(CommentsLoadInProgress());
    try {
      final comments = await repo.getComments(postId);
      emit(CommentsFetched(comments));
    } catch (e) {
      emit(CommentsLoadFailure('Unknown error: $e'));
    }
  }
}

abstract class CommentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {
  CommentsInitial();
}

class CommentsFetched extends CommentsState {
  final List<Comment> comments;

  CommentsFetched(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentsLoadInProgress extends CommentsState {
  CommentsLoadInProgress();
}

class CommentsLoadFailure extends CommentsState {
  final String error;

  CommentsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}