import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'option_model.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String? avatar;
  final OptionModel? type;
  final OptionModel? region;
  final OptionModel? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // Profile fields
  final String firstName;
  final String lastName;
  final String? phone;
  final DateTime? dateOfBirth;
  final String? city;
  final String? area;
  final String? aboutMe;
  final num rating;

  const UserModel({
    required this.id,
    required this.username,
    this.type,
    this.region,
    this.gender,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.dateOfBirth,
    this.city,
    this.area,
    this.aboutMe,
    this.rating = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String?,
      gender: json['gender'] != null
          ? OptionModel.fromJson(json['gender'])
          : null,
      type: json['type'] != null ? OptionModel.fromJson(json['type']) : null,
      region: json['region'] != null
          ? OptionModel.fromJson(json['region'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      city: json['city'] as String?,
      area: json['area'] as String?,
      aboutMe: json['aboutMe'] as String?,
      rating: json['rating'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar,
      'region': region?.toJson(),
      'type': type?.toJson(),
      'gender': gender?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'city': city,
      'area': area,
      'aboutMe': aboutMe,
      'rating': rating,
    };
  }

  String get fullName => '$firstName $lastName';

  String toRawJson() {
    return jsonEncode(toJson());
  }

  factory UserModel.fromRawJson(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  @override
  List<Object?> get props => [
    id,
    username,
    avatar,
    type,
    region,
    gender,
    createdAt,
    updatedAt,
    firstName,
    lastName,
    phone,
    dateOfBirth,
    city,
    area,
    aboutMe,
    rating
  ];

  factory UserModel.emptyUser() {
    return UserModel(
      id: '',
      username: 'Username',
      firstName: 'User',
      lastName: 'Name',
      type: null,
      region: null,
      gender: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    OptionModel? type,
    OptionModel? region,
    OptionModel? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? dateOfBirth,
    String? city,
    String? area,
    String? aboutMe,
    String? avatar,
    num? rating,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      type: type ?? this.type,
      region: region ?? this.region,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      city: city ?? this.city,
      area: area ?? this.area,
      aboutMe: aboutMe ?? this.aboutMe,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
    );
  }
}
