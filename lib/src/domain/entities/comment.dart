import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final String from;
  final String body;

  const Comment(this.id, this.from, this.body);

  @override
  List<Object?> get props => throw UnimplementedError();
}