// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storefront.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Storefront _$StorefrontFromJson(Map<String, dynamic> json) => Storefront(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      website: json['website'] as String,
      facebookUrl: json['facebookUrl'] as String,
      instagramUrl: json['instagramUrl'] as String,
      twitterUrl: json['twitterUrl'] as String,
      linkedinUrl: json['linkedinUrl'] as String,
      featured: json['featured'] as bool,
      featuredExpiryDate: json['featuredExpiryDate'] == null
          ? null
          : DateTime.parse(json['featuredExpiryDate'] as String),
      googleMapsLink: json['googleMapsLink'] as String,
      operatingHours: OperatingHours.fromJson(
          json['operatingHours'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      subcategoryRef: _$JsonConverterFromJson<
              DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          json['subcategory'], const DocumentSerializer().fromJson),
      image: json['image'] == null
          ? null
          : StorageImage.fromJson(json['image'] as Map<String, dynamic>),
      reviewStats:
          ReviewStats.fromJson(json['reviewStats'] as Map<String, dynamic>),
      portfolioImages: (json['portfolioImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StorefrontToJson(Storefront instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'website': instance.website,
      'facebookUrl': instance.facebookUrl,
      'instagramUrl': instance.instagramUrl,
      'twitterUrl': instance.twitterUrl,
      'linkedinUrl': instance.linkedinUrl,
      'featured': instance.featured,
      'featuredExpiryDate': instance.featuredExpiryDate?.toIso8601String(),
      'googleMapsLink': instance.googleMapsLink,
      'operatingHours': instance.operatingHours.toJson(),
      'tags': instance.tags,
      'image': instance.image?.toJson(),
      'reviewStats': instance.reviewStats.toJson(),
      'portfolioImages': instance.portfolioImages,
      'subcategory': _$JsonConverterToJson<
              DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          instance.subcategoryRef, const DocumentSerializer().toJson),
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

StorefrontCreateInput _$StorefrontCreateInputFromJson(
        Map<String, dynamic> json) =>
    StorefrontCreateInput(
      name: json['name'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      website: json['website'] as String,
      facebookUrl: json['facebookUrl'] as String,
      instagramUrl: json['instagramUrl'] as String,
      twitterUrl: json['twitterUrl'] as String,
      linkedinUrl: json['linkedinUrl'] as String,
      operatingHours: OperatingHours.fromJson(
          json['operatingHours'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      subcategoryId: json['subcategoryId'] as String?,
      showOperatingHours: json['showOperatingHours'] as bool,
      featured: json['featured'] as bool,
      googleMapsLink: json['googleMapsLink'] as String,
      featuredExpiryDate: json['featuredExpiryDate'] == null
          ? null
          : DateTime.parse(json['featuredExpiryDate'] as String),
      image: json['image'] == null
          ? null
          : StorageImage.fromJson(json['image'] as Map<String, dynamic>),
      portfolioImages: (json['portfolioImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StorefrontCreateInputToJson(
        StorefrontCreateInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'googleMapsLink': instance.googleMapsLink,
      'website': instance.website,
      'facebookUrl': instance.facebookUrl,
      'instagramUrl': instance.instagramUrl,
      'twitterUrl': instance.twitterUrl,
      'linkedinUrl': instance.linkedinUrl,
      'tags': instance.tags,
      'showOperatingHours': instance.showOperatingHours,
      'operatingHours': instance.operatingHours.toJson(),
      'featured': instance.featured,
      'featuredExpiryDate': instance.featuredExpiryDate?.toIso8601String(),
      'image': instance.image?.toJson(),
      'portfolioImages': instance.portfolioImages,
      'reviewStats': instance.reviewStats.toJson(),
      'subcategory': _$JsonConverterToJson<
              DocumentReference<Map<String, dynamic>>,
              DocumentReference<Map<String, dynamic>>>(
          instance.subcategoryRef, const DocumentSerializer().toJson),
    };

OperatingHours _$OperatingHoursFromJson(Map<String, dynamic> json) =>
    OperatingHours(
      monday: (json['monday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['tuesday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['wednesday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['thursday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      friday: (json['friday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['saturday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      sunday: (json['sunday'] as List<dynamic>)
          .map((e) => OperationWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OperatingHoursToJson(OperatingHours instance) =>
    <String, dynamic>{
      'monday': instance.monday.map((e) => e.toJson()).toList(),
      'tuesday': instance.tuesday.map((e) => e.toJson()).toList(),
      'wednesday': instance.wednesday.map((e) => e.toJson()).toList(),
      'thursday': instance.thursday.map((e) => e.toJson()).toList(),
      'friday': instance.friday.map((e) => e.toJson()).toList(),
      'saturday': instance.saturday.map((e) => e.toJson()).toList(),
      'sunday': instance.sunday.map((e) => e.toJson()).toList(),
    };

OperationWindow _$OperationWindowFromJson(Map<String, dynamic> json) =>
    OperationWindow(
      opens:
          const TimeOfDaySerializer().fromJson((json['opens'] as num).toInt()),
      closes:
          const TimeOfDaySerializer().fromJson((json['closes'] as num).toInt()),
    );

Map<String, dynamic> _$OperationWindowToJson(OperationWindow instance) =>
    <String, dynamic>{
      'opens': const TimeOfDaySerializer().toJson(instance.opens),
      'closes': const TimeOfDaySerializer().toJson(instance.closes),
    };

ReviewStats _$ReviewStatsFromJson(Map<String, dynamic> json) => ReviewStats(
      oneStar: (json['oneStar'] as num).toInt(),
      twoStar: (json['twoStar'] as num).toInt(),
      threeStar: (json['threeStar'] as num).toInt(),
      fourStar: (json['fourStar'] as num).toInt(),
      fiveStar: (json['fiveStar'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewStatsToJson(ReviewStats instance) =>
    <String, dynamic>{
      'oneStar': instance.oneStar,
      'twoStar': instance.twoStar,
      'threeStar': instance.threeStar,
      'fourStar': instance.fourStar,
      'fiveStar': instance.fiveStar,
    };
