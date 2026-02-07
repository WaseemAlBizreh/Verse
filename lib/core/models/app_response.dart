import 'package:equatable/equatable.dart';

import 'meta_model.dart';

class AppResponse<T> extends Equatable {
  const AppResponse({
    required this.success,
    this.data,
    this.meta,
  });

  final bool success;
  final dynamic data;

  /// Optional pagination meta (total, per_page, current_page, last_page).
  final MetaModel? meta;

  factory AppResponse.fromJson(
    Map<String, dynamic> json, {
    bool? success,
  }) {
    final metaJson = json['meta'] as Map<String, dynamic>?;
    return AppResponse<T>(
      success: success ?? json['success'] as bool? ?? false,
      data: json['data'],
      meta: metaJson != null ? MetaModel.fromJson(metaJson) : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT) {
    return {
      'success': success,
      'data': data,
      if (meta != null) 'meta': meta!.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, data, meta];
}
