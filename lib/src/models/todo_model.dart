import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../entities/entities.dart';

@immutable
class Todo extends Equatable {
  Todo(this.task, {this.complete = false, String note = '', String id})
      : note = note ?? '',
        id = id ?? Uuid().v4();

  factory Todo.fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete,
      note: entity.note,
      id: entity.id ?? Uuid().v4(),
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(task: task, id: id, note: note, complete: complete);
  }

  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  List<Object> get props => <Object>[complete, id, note, task];
}
