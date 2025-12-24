import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/models/document_serializer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_category.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class Subcategory {
  final String id;
  final String name;

  @JsonKey(name: "category")
  final DocumentReference<Map<String, dynamic>>? categoryRef;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Category? preloadedCategory;

  @JsonKey(includeToJson: false, includeFromJson: false)
  Future<Category?> get subcategory async {
    if (preloadedCategory != null) {
      return preloadedCategory;
    }

    final ref = categoryRef;
    if (ref != null) {
      return Category.fromSnapshot(await ref.get());
    }
    return null;
  }

  Subcategory({
    required this.id,
    required this.name,
    this.categoryRef,
    Category? category,
  }) : preloadedCategory = category;

  factory Subcategory.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Subcategory.fromJson({"id": snapshot.id, ...snapshot.data()!});
  }

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);

  static List<Subcategory> dummyData() {
    return List.filled(
      10,
      Subcategory(
        name: 'Sub-Category',
        id: '1',
      ),
    );
  }
}
