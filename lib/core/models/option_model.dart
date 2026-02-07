import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String value;
  final String label;

  const OptionModel({required this.value, required this.label});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(value: json['value'] ?? '', label: json['label'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'label': label};
  }

  @override
  List<Object?> get props => [value, label];
}
