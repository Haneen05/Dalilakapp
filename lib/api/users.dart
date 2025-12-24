import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';

class Users {
  final api = FirebaseFirestore.instance;

  static final instance = Users._();

  Users._();

  Future<List<DUser>> findMany({Role? role}) {
    Query<Map<String, dynamic>> collection = api.collection('users');
    if (role != null) {
      collection = collection.where('role', isEqualTo: role.name);
    }
    return collection
        .get()
        .then((users) => users.docs.map(DUser.fromSnapshot).toList());
  }

  Future<DUser> findOne(String id) {
    return api.collection('users').doc(id).get().then(DUser.fromSnapshot);
  }

  Future<void> update(String id, DUserInput user) {
    return api.collection('users').doc(id).update(user.toJson());
  }

  Future<DUser?> findByUid(String uid) async {
    final users =
        await api.collection('users').where('uid', isEqualTo: uid).get();
    if (users.docs.isEmpty) {
      return null;
    }
    return DUser.fromSnapshot(users.docs[0]);
  }

  Future<DUser?> findByPhoneNumber(String phoneNumber) async {
    final users = await api
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    if (users.docs.isEmpty) {
      return null;
    }
    return DUser.fromSnapshot(users.docs[0]);
  }

  Future<DUser> add(DUserInput user) {
    return api
        .collection('users')
        .add(user.toJson())
        .then((user) => user.get().then(DUser.fromSnapshot));
  }

  Future<void> delete(String id) {
    return api.collection('users').doc(id).delete();
  }

  Future<List<Storefront>> getSavedStorefronts(String id) async {
    final savedStorefronts =
        await api.collection('users').doc(id).collection('saved').get();

    final futures = savedStorefronts.docs.map((doc) {
      return (doc['storefront'] as DocumentReference<Map<String, dynamic>>)
          .get()
          .then((storefront) {
        if (!storefront.exists) {
          // in case referenced item was deleted
          return null;
        }

        return Storefront.fromSnapshot(storefront);
      });
    }).toList();

    // remove null items
    return await Future.wait(futures).then((values) =>
        values.where((elem) => elem != null).map((elem) => elem!).toList());
  }

  Future<void> saveStorefront(String id, String storefrontId) async {
    final ref = api.collection('storefronts').doc(storefrontId);
    await api.collection('users').doc(id).collection('saved').add({
      "storefront": ref,
    });
  }

  Future<void> removeSavedStorefront(String id, String storefrontId) async {
    final ref = api.collection('storefronts').doc(storefrontId);
    var querySnapshot = await api
        .collection('users')
        .doc(id)
        .collection('saved')
        .where('storefront', isEqualTo: ref)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<bool> isSaved(String id, String storefrontId) async {
    final ref = api.collection('storefronts').doc(storefrontId);

    return await api
        .collection('users')
        .doc(id)
        .collection('saved')
        .where('storefront', isEqualTo: ref)
        .count()
        .get()
        .then((agg) {
      final count = agg.count;
      return count != null && count > 0;
    });
  }

  Stream<List<DUser>> streamMany({required String role}) {
    return api
        .collection('users')
        .where('role', isEqualTo: role.toString())
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => DUser.fromSnapshot(doc)).toList());
  }
}
