part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => <Object>[];
}

class FilteredTodosLoading extends FilteredTodosState {}

class FilteredTodosLoaded extends FilteredTodosState {
  const FilteredTodosLoaded(
    this.filteredTodos,
    this.activeFilter,
  );

  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  @override
  List<Object> get props => <Object>[filteredTodos, activeFilter];
}
