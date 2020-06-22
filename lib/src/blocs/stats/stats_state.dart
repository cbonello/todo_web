part of 'stats_bloc.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => <Object>[];
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  const StatsLoaded(this.numActive, this.numCompleted);

  final int numActive;
  final int numCompleted;

  @override
  List<Object> get props => <Object>[numActive, numCompleted];
}
