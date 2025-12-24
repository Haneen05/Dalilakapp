import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  final String id;
  final String name;
  final String iconName;

  Category({
    required this.id,
    required this.name,
    required this.iconName,
  });

  factory Category.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Category.fromJson({"id": snapshot.id, ...snapshot.data()!});
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static final Map<String, Widget> iconMap = {
    "health": DIcons.health,
    "legal": DIcons.file,
    "home": DIcons.house,
    "services": DIcons.settings,
    "technology": DIcons.devices,
    "marketing": DIcons.support,
    "academy": DIcons.award,
    "other": DIcons.shoppingBag,
  };

  Widget? get icon => iconMap[iconName];

  static List<Category> dummyData() {
    return List.filled(
      4,
      Category(
        name: 'Category Name',
        iconName: 'health',
        id: '1',
      ),
    );
  }
}
