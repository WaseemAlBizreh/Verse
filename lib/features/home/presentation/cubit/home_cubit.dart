import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void getHomeData() {
    // TODO: fetch home data
  }

  void logout() {}
}
