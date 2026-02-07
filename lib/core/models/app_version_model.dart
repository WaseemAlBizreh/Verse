import 'package:equatable/equatable.dart';

import 'option_model.dart';

class AppVersionModel extends Equatable {
  final int id;
  final String version;
  final OptionModel store;
  final OptionModel platform;
  final String appUrl;
  final bool requiredUpdate;
  final String releaseNotes;

  const AppVersionModel({
    required this.id,
    required this.version,
    required this.store,
    required this.platform,
    required this.appUrl,
    required this.requiredUpdate,
    required this.releaseNotes,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      id: json['id'] as int? ?? 0,
      version: json['version'] as String? ?? '',
      store: OptionModel.fromJson(json['store'] ?? {}),
      platform: OptionModel.fromJson(json['platform'] ?? {}),
      appUrl: json['appUrl'] as String? ?? '',
      requiredUpdate: json['requiredUpdate'] as bool? ?? false,
      releaseNotes: json['releaseNotes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'releaseNotes': releaseNotes,
      'version': version,
      'store': store.toJson(),
      'platform': platform.toJson(),
      'appUrl': appUrl,
      'requiredUpdate': requiredUpdate,
    };
  }

  @override
  List<Object?> get props => [
    id,
    version,
    store,
    platform,
    appUrl,
    requiredUpdate,
    releaseNotes,
  ];
}
