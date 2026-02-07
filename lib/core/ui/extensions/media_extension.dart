
import '../../config/app_config.dart';

extension MediaExtension on String? {
  String? get toImage {
    if (this == null || this!.isEmpty) return null;
    return '$kImageUrl${this!}';
  }
}
