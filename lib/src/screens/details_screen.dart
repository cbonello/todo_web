import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import '../models/models.dart';
import './screens.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, @required this.id})
      : super(key: key ?? AppKeys.todoDetailsScreen);

  final String id;

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);

    return BlocBuilder<TodosBloc, TodosState>(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {
        final Todo todo = (state as TodosLoaded)
            .todos
            .firstWhere((Todo todo) => todo.id == id, orElse: () => null);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo Details'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Delete Todo',
                key: AppKeys.deleteTodoButton,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  todosBloc.add(DeleteTodo(todo));
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
          body: todo == null
              ? Container(key: AppKeys.emptyDetailsContainer)
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                key: AppKeys.detailsScreenCheckBox,
                                value: todo.complete,
                                onChanged: (_) {
                                  todosBloc.add(
                                    UpdateTodo(
                                      todo.copyWith(complete: !todo.complete),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: '${todo.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      todo.task,
                                      key: AppKeys.detailsTodoItemTask,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  todo.note,
                                  key: AppKeys.detailsTodoItemNote,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: AppKeys.editTodoFab,
            tooltip: 'Edit Todo',
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return AddEditScreen(
                            key: AppKeys.editTodoScreen,
                            onSave: (String task, String note) {
                              todosBloc.add(
                                UpdateTodo(
                                  todo.copyWith(task: task, note: note),
                                ),
                              );
                            },
                            isEditing: true,
                            todo: todo,
                          );
                        },
                      ),
                    );
                  },
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
