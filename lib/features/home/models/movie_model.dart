import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.rating,
    required this.certification,
    required this.releaseDate,
    required this.genres,
    required this.isFavourite,
  });

  final int id;
  final String title;
  final String description;
  final String posterUrl;
  final String rating;
  final String certification;
  final String releaseDate;
  final List<GenreModel> genres;
  final bool isFavourite;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final genresList = json['genres'] as List<dynamic>?;
    final genres = genresList != null
        ? genresList
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : <GenreModel>[];

    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      posterUrl: json['poster_url'] as String? ?? '',
      rating: json['rating']?.toString() ?? '0',
      certification: json['certification'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      genres: genres,
      isFavourite: json['is_favourite'] as bool? ?? false,
    );
  }

  String get genresDisplay =>
      genres.map((g) => g.name).toList().join(' , ');

  @override
  List<Object?> get props =>
      [id, title, description, posterUrl, rating, certification, releaseDate, genres, isFavourite];
}
