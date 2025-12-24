// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String,
      score: (json['score'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userRef: _$JsonConverterFromJson<DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          json['user'], const DocumentSerializer().fromJson),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': _$JsonConverterToJson<DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          instance.userRef, const DocumentSerializer().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ReviewCreateInput _$ReviewCreateInputFromJson(Map<String, dynamic> json) =>
    ReviewCreateInput(
      score: (json['score'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ReviewCreateInputToJson(ReviewCreateInput instance) =>
    <String, dynamic>{
      'score': instance.score,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': _$JsonConverterToJson<DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          instance.userRef, const DocumentSerializer().toJson),
    };
