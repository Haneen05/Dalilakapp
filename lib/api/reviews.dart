import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';

class Reviews {
  final api = FirebaseFirestore.instance;

  static final instance = Reviews._();

  Reviews._();

  Future<List<Review>> findMany({
    required String storefrontId,
    String? userId,
  }) {
    Query<Map<String, dynamic>> collection = api
        .collection('storefronts')
        .doc(storefrontId)
        .collection('reviews')
        .orderBy('createdAt', descending: true);

    if (userId != null) {
      collection =
          collection.where('user', isEqualTo: api.doc('users/$userId'));
    }

    return collection
        .get()
        .then((reviews) => reviews.docs.map(Review.fromSnapshot).toList());
  }

  Future<void> add(String storefrontId, ReviewCreateInput input) async {
    final existing = await api
        .collection('storefronts')
        .doc(storefrontId)
        .get()
        .then(Storefront.fromSnapshot);

    await api
        .collection('storefronts')
        .doc(storefrontId)
        .collection('reviews')
        .add(input.toJson());

    await api.collection('storefronts').doc(storefrontId).update({
      ...existing.toJson(),
      "reviewStats": existing.reviewStats.withAddedRating(input.score).toJson(),
    });
  }
}
