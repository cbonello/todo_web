import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '../blocs.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((TodosState state) {
      if (state is TodosLoaded) {
        add(UpdateStats(state.todos));
      }
    });
  }

  final TodosBloc todosBloc;
  StreamSubscription<TodosState> todosSubscription;

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      final int numActive =
          event.todos.where((Todo todo) => !todo.complete).toList().length;
      final int numCompleted =
          event.todos.where((Todo todo) => todo.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    todosSubscription?.cancel();
    return super.close();
  }
}
