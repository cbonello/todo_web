part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadTodos extends TodosEvent {}

class AddTodo extends TodosEvent {
  const AddTodo(this.todo);

  final Todo todo;

  @override
  List<Object> get props => <Object>[todo];
}

class UpdateTodo extends TodosEvent {
  const UpdateTodo(this.updatedTodo);

  final Todo updatedTodo;

  @override
  List<Object> get props => <Object>[updatedTodo];
}

class DeleteTodo extends TodosEvent {
  const DeleteTodo(this.todo);

  final Todo todo;

  @override
  List<Object> get props => <Object>[todo];
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
