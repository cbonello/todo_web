import 'package:flutter/material.dart';

import '../keys.dart';
import '../models/models.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: AppKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (int index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((AppTab tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.todos ? Icons.list : Icons.show_chart,
            key: tab == AppTab.todos ? AppKeys.todoTab : AppKeys.statsTab,
          ),
          title: Text(tab == AppTab.stats ? 'Stats' : 'Todos'),
        );
      }).toList(),
    );
  }
}
