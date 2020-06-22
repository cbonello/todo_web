import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import '../models/models.dart';

class ExtraActions extends StatelessWidget {
  const ExtraActions() : super(key: AppKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {
        if (state is TodosLoaded) {
          final bool allComplete =
              (todosBloc.state as TodosLoaded).todos.every((Todo todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            key: AppKeys.extraActionsPopupMenuButton,
            onSelected: (ExtraAction action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  todosBloc.add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  todosBloc.add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: AppKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete ? 'Mark all incomplete' : 'Mark all complete',
                ),
              ),
              const PopupMenuItem<ExtraAction>(
                key: AppKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  'Clear completed',
                ),
              ),
            ],
          );
        }
        return Container(key: AppKeys.extraActionsEmptyContainer);
      },
    );
  }
}
