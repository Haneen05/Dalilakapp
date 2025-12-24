import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';

class Categories {
  final api = FirebaseFirestore.instance;

  static final instance = Categories._();

  Categories._();

  Future<List<Category>> findMany() {
    return api.collection('categories').get().then(
        (categories) => categories.docs.map(Category.fromSnapshot).toList());
  }

  Future<Category> findOne(String id) {
    return api
        .collection('categories')
        .doc(id)
        .get()
        .then(Category.fromSnapshot);
  }
}
