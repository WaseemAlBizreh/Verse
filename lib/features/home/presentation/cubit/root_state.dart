part of 'root_cubit.dart';

class RootState {
  const RootState({
    this.unreadNotificationCount = 0,
    this.scaffoldKey,
  });

  final int unreadNotificationCount;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  RootState copyWith({
    int? unreadNotificationCount,
    GlobalKey<ScaffoldState>? scaffoldKey,
  }) {
    return RootState(
      unreadNotificationCount: unreadNotificationCount ?? this.unreadNotificationCount,
      scaffoldKey: scaffoldKey ?? this.scaffoldKey,
    );
  }
}
