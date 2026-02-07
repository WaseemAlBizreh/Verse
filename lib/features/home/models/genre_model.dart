import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  const GenreModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int id;
  final String name;
  final String slug;

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, slug];
}
