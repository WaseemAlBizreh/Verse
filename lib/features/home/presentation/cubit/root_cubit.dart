import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'root_state.dart';

@singleton
class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootState(scaffoldKey: GlobalKey<ScaffoldState>()));

  void getUnreadNotificationCount() {
    // TODO: fetch from API; for now emit stub
    emit(state.copyWith(unreadNotificationCount: 0));
  }
}
