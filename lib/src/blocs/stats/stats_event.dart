part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  const UpdateStats(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => <Object>[todos];
}
