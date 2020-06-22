import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../keys.dart';
import './widgets.dart';

class Stats extends StatelessWidget {
  const Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatsBloc statsBloc = BlocProvider.of<StatsBloc>(context);
    return BlocBuilder<StatsBloc, StatsState>(
      bloc: statsBloc,
      builder: (BuildContext context, StatsState state) {
        if (state is StatsLoading) {
          return const LoadingIndicator(key: AppKeys.statsLoadingIndicator);
        } else if (state is StatsLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Completed Todos',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numCompleted}',
                    key: AppKeys.statsNumCompleted,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Active Todos',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numActive}',
                    key: AppKeys.statsNumActive,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(key: AppKeys.emptyStatsContainer);
        }
      },
    );
  }
}
