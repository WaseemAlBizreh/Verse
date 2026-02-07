import 'package:equatable/equatable.dart';

class AppResponse<T> extends Equatable {
  final bool success;
  final String timestamp;
  final dynamic data;
  final ApiInfo? apiInfo;

  const AppResponse({
    required this.success,
    required this.timestamp,
    this.data,
    this.apiInfo,
  });

  factory AppResponse.fromJson(Map<String, dynamic> json) {
    return AppResponse<T>(
      success: json['success'] as bool? ?? false,
      timestamp: json['timestamp'] as String? ?? '',
      data: json['data'],
      apiInfo: json['apiInfo'] != null
          ? ApiInfo.fromJson(json['apiInfo'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT) {
    return {
      'success': success,
      'timestamp': timestamp,
      'data': data,
      'apiInfo': apiInfo?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, timestamp, data, apiInfo];
}

class ApiInfo extends Equatable {
  final String baseUrl;
  final String version;

  const ApiInfo({required this.baseUrl, required this.version});

  factory ApiInfo.fromJson(Map<String, dynamic> json) {
    return ApiInfo(
      baseUrl: json['baseUrl'] as String? ?? '',
      version: json['version'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'baseUrl': baseUrl, 'version': version};
  }

  @override
  List<Object?> get props => [baseUrl, version];
}
