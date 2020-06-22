import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import '../models/models.dart';
import '../screens/screens.dart';
import './widgets.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (
        BuildContext context,
        FilteredTodosState state,
      ) {
        if (state is FilteredTodosLoading) {
          return const LoadingIndicator(key: AppKeys.todosLoading);
        } else if (state is FilteredTodosLoaded) {
          final List<Todo> todos = state.filteredTodos;
          return ListView.builder(
            key: AppKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final Todo todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (_) {
                  todosBloc.add(DeleteTodo(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: AppKeys.snackbar,
                    todo: todo,
                    onUndo: () => todosBloc.add(AddTodo(todo)),
                  ));
                },
                onTap: () async {
                  final Todo removedTodo = await Navigator.of(context).push<Todo>(
                    MaterialPageRoute<Todo>(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                      key: AppKeys.snackbar,
                      todo: todo,
                      onUndo: () => todosBloc.add(AddTodo(todo)),
                    ));
                  }
                },
                onCheckboxChanged: (_) {
                  todosBloc.add(
                    UpdateTodo(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: AppKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
