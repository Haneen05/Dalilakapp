// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      featured: json['featured'] as bool,
      featuredExpiryDate: json['featuredExpiryDate'] == null
          ? null
          : DateTime.parse(json['featuredExpiryDate'] as String),
      image: json['image'] == null
          ? null
          : StorageImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'featured': instance.featured,
      'featuredExpiryDate': instance.featuredExpiryDate?.toIso8601String(),
      'url': instance.url,
      'image': instance.image?.toJson(),
    };

OfferCreateInput _$OfferCreateInputFromJson(Map<String, dynamic> json) =>
    OfferCreateInput(
      name: json['name'] as String,
      url: json['url'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      featured: json['featured'] as bool,
      featuredExpiryDate: json['featuredExpiryDate'] == null
          ? null
          : DateTime.parse(json['featuredExpiryDate'] as String),
      image: json['image'] == null
          ? null
          : StorageImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferCreateInputToJson(OfferCreateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tags': instance.tags,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'featured': instance.featured,
      'url': instance.url,
      'featuredExpiryDate': instance.featuredExpiryDate?.toIso8601String(),
      'image': instance.image?.toJson(),
    };
