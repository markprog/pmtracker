
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_nav_bar_states.dart';

class HomeNavBarCubit extends Cubit<HomeNavBarState> {
  HomeNavBarCubit() : super(HomeNavBarState(0));
  void changeTo(int index) => emit(HomeNavBarState(index));
}