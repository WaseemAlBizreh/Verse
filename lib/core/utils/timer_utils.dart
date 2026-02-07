import 'package:intl/intl.dart';

class TimerUtils {
  static String formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    final minutesFormatted = NumberFormat('00').format(minutes);
    final secondsFormatted = NumberFormat('00').format(remainingSeconds);

    return '$minutesFormatted:${secondsFormatted}s';
  }

  static String formatTimerReadable(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    if (minutes == 0) {
      return '$remainingSeconds ${remainingSeconds == 1 ? 'second' : 'seconds'}';
    } else if (remainingSeconds == 0) {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    } else {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} $remainingSeconds ${remainingSeconds == 1 ? 'second' : 'seconds'}';
    }
  }

  static String formatTimerExtended(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    final hoursFormatted = NumberFormat('00').format(hours);
    final minutesFormatted = NumberFormat('00').format(minutes);
    final secondsFormatted = NumberFormat('00').format(remainingSeconds);

    return '$hoursFormatted:$minutesFormatted:$secondsFormatted';
  }
}
