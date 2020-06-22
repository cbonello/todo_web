part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class UpdateFilter extends FilteredTodosEvent {
  const UpdateFilter(this.filter);

  final VisibilityFilter filter;

  @override
  List<Object> get props => <Object>[filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateTodos extends FilteredTodosEvent {
  const UpdateTodos(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => <Object>[todos];

  @override
  String toString() => 'UpdateTodos { todos: $todos }';
}
