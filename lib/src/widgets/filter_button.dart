import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import '../models/models.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({this.visible, Key key}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = Theme.of(context).textTheme.bodyText2;
    final TextStyle activeStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Theme.of(context).accentColor);
    final FilteredTodosBloc filteredTodosBloc =
        BlocProvider.of<FilteredTodosBloc>(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        bloc: filteredTodosBloc,
        builder: (BuildContext context, FilteredTodosState state) {
          final _Button button = _Button(
            onSelected: (VisibilityFilter filter) {
              filteredTodosBloc.add(UpdateFilter(filter));
            },
            activeFilter:
                state is FilteredTodosLoaded ? state.activeFilter : VisibilityFilter.all,
            activeStyle: activeStyle,
            defaultStyle: defaultStyle,
          );
          return AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 150),
            child: visible ? button : IgnorePointer(child: button),
          );
        });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: AppKeys.filterButton,
      tooltip: 'Filter Todos',
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            'Show All',
            style: activeFilter == VisibilityFilter.all ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            'Show Active',
            style: activeFilter == VisibilityFilter.active ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            'Show Completed',
            style:
                activeFilter == VisibilityFilter.completed ? activeStyle : defaultStyle,
          ),
        ),
      ],
      icon: const Icon(Icons.filter_list),
    );
  }
}
