part of 'bottm_bar_bloc.dart';

class BottomBarState extends Equatable {
  final BottomBarItem bottomBarItem;
  final int index;

  const BottomBarState(this.bottomBarItem, this.index);

  @override
  List<Object> get props => [bottomBarItem, index];
}