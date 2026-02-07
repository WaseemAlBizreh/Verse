import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class DateConverter {
  static DateTime? stringToDate(String? dateString, {String? format}) {
    if (dateString == null) {
      return null;
    }

    DateTime localTime = DateFormat(
      format ?? "yyyy-MM-ddTHH:mm:ss",
    ).parse(dateString, true);
    return localTime;
  }

  static String dateToString(DateTime? date, {String format = "dd/MM/yyyy"}) {
    if (date == null) return "-------";
    // Always use English locale for date numbers
    if (format.contains("a")) {
      // Format date part in English, AM/PM in Arabic
      final dateFormat = format.replaceAll("a", "").trim();
      final datePart = DateFormat(dateFormat, "en").format(date);
      final amPmPart = DateFormat("aa", "ar").format(date);
      return "$datePart $amPmPart".trim();
    }
    return DateFormat(format, "en").format(date);
  }

  static String timeToString(
    DateTime? time, {
    format = "hh:mm",
    String? local,
  }) {
    if (time == null) return "-------";
    return "${DateFormat(format).format(time)} ${DateFormat("aa").format(time)}";
  }

  static DateTime toDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static String workingHoursToString(
    DateTime startTime,
    DateTime endTime, {
    String format = "h:mm a",
  }) {
    final startFormatted = DateFormat(format).format(startTime);
    final endFormatted = DateFormat(format).format(endTime);
    final startDay = DateFormat("EEE").format(startTime);
    final endDay = DateFormat("EEE").format(endTime);

    return '$startDay - $endDay, $startFormatted - $endFormatted';
  }

  /// Format a UTC DateTime as a local date string.
  static String dateUTCToString(DateTime date, {String format = "dd/MM/yyyy"}) {
    return dateToString(date.toLocal(), format: format);
  }

  /// Format a UTC DateTime as a local time string.
  static String timeUTCToString(DateTime time, {String format = "hh:mm"}) {
    return timeToString(time.toLocal(), format: format);
  }

  static String timeDifference(DateTime startDateTime, DateTime endDateTime) {
    final difference = endDateTime.difference(startDateTime.toLocal());

    if (difference.inDays > 2) {
      final formattedDate = DateConverter.dateUTCToString(startDateTime);
      final formattedTime = DateConverter.timeUTCToString(startDateTime);
      return 'time_date_at_time'.tr(
        namedArgs: {'date': formattedDate, 'time': formattedTime},
      );
    }
    if (difference.inDays > 1) {
      final formattedTime = DateConverter.timeUTCToString(startDateTime);
      return 'time_yesterday_at'.tr(namedArgs: {'time': formattedTime});
    }
    if (difference.inDays > 0) {
      final count = difference.inDays;
      return (count == 1 ? 'time_day_ago' : 'time_days_ago').tr(
        namedArgs: {'count': count.toString()},
      );
    } else if (difference.inHours > 0) {
      final count = difference.inHours;
      return (count == 1 ? 'time_hour_ago' : 'time_hours_ago').tr(
        namedArgs: {'count': count.toString()},
      );
    } else if (difference.inMinutes > 0) {
      final count = difference.inMinutes;
      return (count == 1 ? 'time_minute_ago' : 'time_minutes_ago').tr(
        namedArgs: {'count': count.toString()},
      );
    } else {
      return 'time_just_now'.tr();
    }
  }
}
