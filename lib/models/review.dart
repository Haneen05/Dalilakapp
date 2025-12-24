import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models/document_serializer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class Review {
  final String id;
  final int score;
  final String title;
  final String description;
  final DateTime createdAt;

  @JsonKey(name: "user")
  final DocumentReference<Map<String, dynamic>>? userRef;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final DUser? preloadedUser;

  @JsonKey(includeToJson: false, includeFromJson: false)
  Future<DUser?> get user async {
    if (preloadedUser != null) {
      return preloadedUser;
    }

    final ref = userRef;
    if (ref != null) {
      return DUser.fromSnapshot(await ref.get());
    }
    return null;
  }

  Review({
    required this.id,
    required this.score,
    required this.title,
    required this.description,
    required this.createdAt,
    this.userRef,
    DUser? user,
  }) : preloadedUser = user;

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Review.fromJson({"id": snapshot.id, ...snapshot.data()!});
  }

  static List<Review> dummyData() {
    return List.filled(
      3,
      Review(
        id: '1',
        createdAt: DateTime.now(),
        description: '',
        score: 1,
        title: '',
        user: DUser.dummyData()[0],
      ),
    );
  }
}

@JsonSerializable(explicitToJson: true)
@DocumentSerializer()
class ReviewCreateInput {
  final int score;
  final String title;
  final String description;
  final DateTime createdAt;

  @JsonKey(includeToJson: false)
  final String userId;

  @JsonKey(name: "user", includeToJson: true)
  DocumentReference<Map<String, dynamic>>? get userRef {
    return FirebaseFirestore.instance.doc('users/$userId');
  }

  ReviewCreateInput({
    required this.score,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() => _$ReviewCreateInputToJson(this);

  factory ReviewCreateInput.fromJson(Map<String, dynamic> json) =>
      _$ReviewCreateInputFromJson(json);
}
