// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryRef: _$JsonConverterFromJson<
              DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          json['category'], const DocumentSerializer().fromJson),
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$JsonConverterToJson<DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          instance.categoryRef, const DocumentSerializer().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) {

   return json == null ? null : json.runtimeType == String ?null: fromJson(json as Json);
}

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
