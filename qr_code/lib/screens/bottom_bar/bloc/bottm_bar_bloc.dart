import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/core/enums/bottom_bar.dart';
part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(const BottomBarState(BottomBarItem.home, 0));
  void getBottomBarItem (BottomBarItem bottomBarItem) {
    switch (bottomBarItem) {
      case BottomBarItem.home:
      emit(BottomBarState(bottomBarItem, 0));
      break;     
      case BottomBarItem.account:
      emit(BottomBarState(bottomBarItem, 1));
      break;
    }
  }
}