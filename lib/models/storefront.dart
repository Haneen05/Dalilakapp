import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/models/document_serializer.dart';
import 'package:daleelakappx/models/time_of_day_serializer.dart';
import 'package:daleelakappx/screens/storefronts/operating_hours.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storefront.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class Storefront {
  final String id;
  final String name;
  final String description;
  final String email;
  final String address;
  final String phoneNumber;
  final String website;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;
  final String linkedinUrl;
  final bool featured;
  final DateTime? featuredExpiryDate;
  final String googleMapsLink;
  final OperatingHours operatingHours;
  final List<String> tags;
  final StorageImage? image;
  final ReviewStats reviewStats;
  final List<String>? portfolioImages;

  @JsonKey(name: "subcategory")
  final DocumentReference<Map<String, dynamic>>? subcategoryRef;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Subcategory? preloadedSubcategory;

  @JsonKey(includeToJson: false, includeFromJson: false)
  Future<Subcategory?> get subcategory async {
    if (preloadedSubcategory != null) {
      return preloadedSubcategory;
    }

    final ref = subcategoryRef;
    if (ref != null) {
      return Subcategory.fromSnapshot(await ref.get());
    }
    return null;
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool get isFeatured {
    final expiryDate = featuredExpiryDate;
    return featured &&
        (expiryDate == null || expiryDate.isAfter(DateTime.now()));
  }

  Storefront({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.website,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.linkedinUrl,
    required this.featured,
    required this.featuredExpiryDate,
    required this.googleMapsLink,
    required this.operatingHours,
    required this.tags,
    this.subcategoryRef,
    Subcategory? subcategory,
    required this.image,
    required this.reviewStats,
    this.portfolioImages,
  }) : preloadedSubcategory = subcategory;

  factory Storefront.fromJson(Map<String, dynamic> json) =>
      _$StorefrontFromJson(json);

  Map<String, dynamic> toJson() => _$StorefrontToJson(this);

  factory Storefront.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Storefront.fromJson({"id": snapshot.id, ...snapshot.data()!});
  }

  static List<Storefront> dummyData() {
    return List.filled(
      7,
      Storefront(
        id: '1',
        subcategory: Subcategory.dummyData()[0],
        featured: false,
        name: 'name',
        description: 'description',
        email: 'email',
        address: 'address',
        phoneNumber: 'phoneNumber',
        website: 'website',
        facebookUrl: '',
        linkedinUrl: '',
        instagramUrl: '',
        twitterUrl: '',
        googleMapsLink: '',
        operatingHours: OperatingHours(
          monday: [
            OperationWindow(
              opens: const TimeOfDay(hour: 8, minute: 0),
              closes: const TimeOfDay(hour: 16, minute: 0),
            ),
          ],
          tuesday: [],
          wednesday: [],
          thursday: [],
          friday: [],
          saturday: [],
          sunday: [],
        ),
        tags: ["tag"],
        featuredExpiryDate: null,
        image: null,
        reviewStats: ReviewStats(
          oneStar: 0,
          twoStar: 0,
          threeStar: 0,
          fourStar: 0,
          fiveStar: 0,
        ),
        portfolioImages: [],
      ),
    );
  }
}

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class StorefrontCreateInput {
  final String name;
  final String description;
  final String email;
  final String address;
  final String phoneNumber;
  final String googleMapsLink;
  final String website;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;
  final String linkedinUrl;
  final List<String> tags;
  final bool showOperatingHours;
  final OperatingHours operatingHours;
  final bool featured;
  final DateTime? featuredExpiryDate;
  final StorageImage? image;
  final List<String>? portfolioImages;

  @JsonKey(includeToJson: true)
  final ReviewStats reviewStats = ReviewStats(
    oneStar: 0,
    twoStar: 0,
    threeStar: 0,
    fourStar: 0,
    fiveStar: 0,
  );

  @JsonKey(includeToJson: false)
  final String? subcategoryId;

  @JsonKey(name: "subcategory", includeToJson: true)
  DocumentReference<Map<String, dynamic>>? get subcategoryRef {
    if (subcategoryId == null) {
      return null;
    }
    return FirebaseFirestore.instance.doc('subcategories/$subcategoryId');
  }

  StorefrontCreateInput({
    required this.name,
    required this.description,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.website,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.linkedinUrl,
    required this.operatingHours,
    required this.tags,
    required this.subcategoryId,
    required this.showOperatingHours,
    required this.featured,
    required this.googleMapsLink,
    required this.featuredExpiryDate,
    this.image,
    this.portfolioImages,
  });

  factory StorefrontCreateInput.blank() {
    return StorefrontCreateInput(
      name: '',
      description: '',
      email: '',
      address: '',
      phoneNumber: '',
      website: '',
      facebookUrl: '',
      instagramUrl: '',
      twitterUrl: '',
      linkedinUrl: '',
      operatingHours: OperatingHours.blank(),
      tags: [],
      subcategoryId: null,
      showOperatingHours: true,
      featured: false,
      googleMapsLink: '',
      featuredExpiryDate: null,
      image: null,
      portfolioImages: [],
    );
  }

  Map<String, dynamic> toJson() => _$StorefrontCreateInputToJson(this);

  factory StorefrontCreateInput.fromJson(Map<String, dynamic> json) =>
      _$StorefrontCreateInputFromJson(json);

  StorefrontCreateInput withImage(StorageImage? image) {
    return StorefrontCreateInput(
      name: name,
      description: description,
      email: email,
      address: address,
      phoneNumber: phoneNumber,
      website: website,
      facebookUrl: facebookUrl,
      instagramUrl: instagramUrl,
      twitterUrl: twitterUrl,
      linkedinUrl: linkedinUrl,
      operatingHours: operatingHours,
      tags: tags,
      subcategoryId: subcategoryId,
      showOperatingHours: showOperatingHours,
      featured: featured,
      googleMapsLink: googleMapsLink,
      featuredExpiryDate: featuredExpiryDate,
      image: image,
      portfolioImages: portfolioImages,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OperatingHours {
  final List<OperationWindow> monday;
  final List<OperationWindow> tuesday;
  final List<OperationWindow> wednesday;
  final List<OperationWindow> thursday;
  final List<OperationWindow> friday;
  final List<OperationWindow> saturday;
  final List<OperationWindow> sunday;

  OperatingHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingHoursToJson(this);

  factory OperatingHours.blank() {
    return OperatingHours(
      monday: [],
      tuesday: [],
      wednesday: [],
      thursday: [],
      friday: [],
      saturday: [],
      sunday: [],
    );
  }

  List<(String day, List<OperationWindow>?)> values() {
    return [
      ("Monday", monday),
      ("Tuesday", tuesday),
      ("Wednesday", wednesday),
      ("Thursday", thursday),
      ("Friday", friday),
      ("Saturday", saturday),
      ("Sunday", sunday),
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      "monday": monday.map((window) => window.toMap()).toList(),
      "tuesday": tuesday.map((window) => window.toMap()).toList(),
      "wednesday": wednesday.map((window) => window.toMap()).toList(),
      "thursday": thursday.map((window) => window.toMap()).toList(),
      "friday": friday.map((window) => window.toMap()).toList(),
      "saturday": saturday.map((window) => window.toMap()).toList(),
      "sunday": sunday.map((window) => window.toMap()).toList(),
    };
  }

  factory OperatingHours.fromInput(OperatingHoursInput input) {
    OperationWindow mapper(OperationWindowInput window) {
      return OperationWindow(opens: window.opens, closes: window.closes);
    }

    return OperatingHours(
      monday: input.monday.map(mapper).toList(),
      tuesday: input.thursday.map(mapper).toList(),
      wednesday: input.wednesday.map(mapper).toList(),
      thursday: input.thursday.map(mapper).toList(),
      friday: input.friday.map(mapper).toList(),
      saturday: input.saturday.map(mapper).toList(),
      sunday: input.sunday.map(mapper).toList(),
    );
  }
}

@JsonSerializable(explicitToJson: true)
@TimeOfDaySerializer()
class OperationWindow {
  final TimeOfDay opens;
  final TimeOfDay closes;

  OperationWindow({
    required this.opens,
    required this.closes,
  });

  Map<String, dynamic> toJson() => _$OperationWindowToJson(this);

  factory OperationWindow.fromJson(Map<String, dynamic> json) =>
      _$OperationWindowFromJson(json);

  String formattedTime() {
    return '${_formatTimeOfDay(opens)} – ${_formatTimeOfDay(closes)}';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  Map<String, dynamic> toMap() {
    return {
      "opens": opens.hour * 60 + opens.minute,
      "closes": closes.hour * 60 + closes.minute,
    };
  }
}

@JsonSerializable(explicitToJson: true)
class ReviewStats {
  final int oneStar;
  final int twoStar;
  final int threeStar;
  final int fourStar;
  final int fiveStar;

  ReviewStats({
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
  });

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<int> get values {
    return [oneStar, twoStar, threeStar, fourStar, fiveStar];
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<double> get percentages {
    final total = this.total;
    return values.map((value) => total > 0 ? value / total : 0.0).toList();
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  double get average {
    double sum = 0;
    int total = 0;
    for (var (index, value) in values.indexed) {
      sum += (index + 1) * value;
      total += value;
    }
    return total > 0 ? sum / total : 0;
  }

  int get total {
    return values.reduce((i, j) => i + j);
  }

  Map<String, dynamic> toJson() => _$ReviewStatsToJson(this);

  factory ReviewStats.fromJson(Map<String, dynamic> json) =>
      _$ReviewStatsFromJson(json);

  factory ReviewStats.fromValues(List<int> values) {
    assert(values.length == 5);
    return ReviewStats(
      oneStar: values[0],
      twoStar: values[1],
      threeStar: values[2],
      fourStar: values[3],
      fiveStar: values[4],
    );
  }

  ReviewStats withAddedRating(int rating, {int add = 1}) {
    assert(rating >= 1 && rating <= 5);

    final updated = values.indexed.map((item) {
      var (index, value) = item;
      if (index + 1 == rating) {
        return value + add;
      }
      return value;
    }).toList();
    return ReviewStats.fromValues(updated);
  }
}
