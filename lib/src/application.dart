import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/blocs.dart';
import './keys.dart';
import './models/models.dart';
import './repositories/repositories.dart';
import './screens/screens.dart';

void runTodoApp(TodosRepository repository) {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    BlocProvider<TodosBloc>(
      create: (BuildContext context) {
        return TodosBloc(todosRepository: repository)..add(LoadTodos());
      },
      child: const TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  const TodosApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);

    return MaterialApp(
      onGenerateTitle: (_) => 'Todo',
      routes: <String, Widget Function(BuildContext)>{
        HomeScreen.route: (BuildContext context) {
          return MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<TabBloc>(
                create: (BuildContext context) => TabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (BuildContext context) => FilteredTodosBloc(todosBloc: todosBloc),
              ),
              BlocProvider<StatsBloc>(
                create: (BuildContext context) => StatsBloc(todosBloc: todosBloc),
              ),
            ],
            child: const HomeScreen(),
          );
        },
        AddEditScreen.route: (BuildContext context) {
          return AddEditScreen(
            key: AppKeys.addTodoScreen,
            onSave: (String task, String note) {
              todosBloc.add(AddTodo(Todo(task, note: note)));
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
