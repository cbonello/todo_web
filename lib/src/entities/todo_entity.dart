import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TodoEntity extends Equatable {
  const TodoEntity({
    @required this.task,
    this.id,
    @required this.note,
    this.complete = false,
  });

  factory TodoEntity.fromJson(Map<String, Object> json) {
    return TodoEntity(
      task: json['task'] as String,
      id: json['id'] as String,
      note: json['note'] as String,
      complete: json['complete'] as bool,
    );
  }

  Map<String, Object> toJson() {
    return <String, Object>{
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
    };
  }

  final bool complete;
  final String id;
  final String note;
  final String task;

  @override
  List<Object> get props => <Object>[task, id, note, complete];
}
