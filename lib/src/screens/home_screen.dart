import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import './screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = BlocProvider.of<TabBloc>(context);

    return BlocBuilder<TabBloc, AppTab>(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo'),
            actions: <Widget>[
              FilterButton(visible: activeTab == AppTab.todos),
              const ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? const FilteredTodos() : const Stats(),
          floatingActionButton: FloatingActionButton(
            key: AppKeys.addTodoFab,
            onPressed: () => Navigator.pushNamed(context, AddEditScreen.route),
            tooltip: 'Add Todo',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (AppTab tab) => tabBloc.add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
