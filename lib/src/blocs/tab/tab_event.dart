part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class UpdateTab extends TabEvent {
  const UpdateTab(this.tab);

  final AppTab tab;

  @override
  List<Object> get props => <Object>[tab];
}
