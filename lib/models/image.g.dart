// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageImage _$StorageImageFromJson(Map<String, dynamic> json) => StorageImage(
      path: json['path'] as String,
      url: json['url'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$StorageImageToJson(StorageImage instance) =>
    <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
      'size': instance.size,
    };
