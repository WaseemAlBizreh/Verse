import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String type;
  final int contentId;

  const SliderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.contentId,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      type: json['type'] as String? ?? 'movie',
      contentId: json['content_id'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, title, description, imageUrl, type, contentId];
}
