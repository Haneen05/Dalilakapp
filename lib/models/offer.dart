import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'offer.g.dart';

@JsonSerializable(explicitToJson: true)
class Offer {
  final String id;
  final String name;
  final List<String> tags;
  final DateTime expiryDate;
  final bool featured;
  final DateTime? featuredExpiryDate;
  final String url;
  final StorageImage? image;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool get isFeatured {
    final expiryDate = featuredExpiryDate;
    return featured &&
        (expiryDate == null || expiryDate.isAfter(DateTime.now()));
  }

  Offer({
    required this.id,
    required this.name,
    required this.url,
    required this.tags,
    required this.expiryDate,
    required this.featured,
    required this.featuredExpiryDate,
    required this.image,
  });

  Map<String, dynamic> toJson() => _$OfferToJson(this);

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  factory Offer.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Offer.fromJson({"id": snapshot.id, ...snapshot.data()!});

  static List<Offer> dummyData() {
    return List.filled(
      3,
      Offer(
        name: '',
        expiryDate: DateTime.now(),
        featured: false,
        id: '',
        tags: ['tag'],
        featuredExpiryDate: null,
        image: null,
        url: 'https://test.com',
      ),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OfferCreateInput {
  final String name;
  final List<String> tags;
  final DateTime expiryDate;
  final bool featured;
  final String url;
  final DateTime? featuredExpiryDate;
  final StorageImage? image;

  OfferCreateInput({
    required this.name,
    required this.url,
    required this.tags,
    required this.expiryDate,
    required this.featured,
    required this.featuredExpiryDate,
    this.image,
  });

  Map<String, dynamic> toJson() => _$OfferCreateInputToJson(this);

  factory OfferCreateInput.fromJson(Map<String, dynamic> json) =>
      _$OfferCreateInputFromJson(json);

  OfferCreateInput withImage(StorageImage? image) {
    return OfferCreateInput(
      name: name,
      url: url,
      tags: tags,
      expiryDate: expiryDate,
      featured: featured,
      featuredExpiryDate: featuredExpiryDate,
      image: image,
    );
  }
}
