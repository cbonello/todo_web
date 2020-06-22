part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => <Object>[];
}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  const TodosLoaded([this.todos = const <Todo>[]]);

  final List<Todo> todos;

  @override
  List<Object> get props => <Object>[todos];
}

class TodosNotLoaded extends TodosState {}
