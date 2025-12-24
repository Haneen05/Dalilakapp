import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';

class Subcategories {
  final api = FirebaseFirestore.instance;

  static final instance = Subcategories._();

  Subcategories._();

  Future<List<Subcategory>> findMany({String? categoryId}) {
    Query<Map<String, dynamic>> collection = api.collection('subcategories');
    if (categoryId != null) {
      collection = collection.where('category',
          isEqualTo: api.doc('categories/$categoryId'));
    }
    return collection.get().then((subcategories) =>
        subcategories.docs.map(Subcategory.fromSnapshot).toList());
  }

  Future<Subcategory> findOne(String id) {
    return api
        .collection('subcategories')
        .doc(id)
        .get()
        .then(Subcategory.fromSnapshot);
  }

  Future<List<Subcategory>> findByCategory(String categoryId) {
    return api
        .collection('subcategories')
        .where('category', isEqualTo: api.doc('categories/$categoryId'))
        .get()
        .then((subcategories) =>
            subcategories.docs.map(Subcategory.fromSnapshot).toList());
  }
}
