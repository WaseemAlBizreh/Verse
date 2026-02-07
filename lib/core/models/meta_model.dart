import 'package:equatable/equatable.dart';

class MetaModel extends Equatable {
  const MetaModel({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: json['total'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
    };
  }

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;

  @override
  List<Object?> get props => [total, perPage, currentPage, lastPage];
}
