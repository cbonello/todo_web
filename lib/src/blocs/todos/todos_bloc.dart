import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../entities/entities.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({@required this.todosRepository});

  final TodosRepository todosRepository;

  @override
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final List<TodoEntity> todos = await todosRepository.loadTodos();
      yield TodosLoaded(todos.map((TodoEntity e) => Todo.fromEntity(e)).toList());
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = List<Todo>.from(
        (state as TodosLoaded).todos,
      )..add(event.todo);
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = (state as TodosLoaded).todos.map((Todo todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = (state as TodosLoaded)
          .todos
          .where((Todo todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoaded) {
      final bool allComplete =
          (state as TodosLoaded).todos.every((Todo todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoaded)
          .todos
          .map((Todo todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos =
          (state as TodosLoaded).todos.where((Todo todo) => !todo.complete).toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((Todo todo) => todo.toEntity()).toList(),
    );
  }
}
