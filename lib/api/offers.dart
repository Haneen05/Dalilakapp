import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Offers {
  final api = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  static final instance = Offers._();

  Offers._();

  Future<List<Offer>> findMany({int? limit}) {
    Query<Map<String, dynamic>> collection = api.collection('offers');

    if (limit != null) {
      collection = collection.limit(limit);
    }

    return collection
        .get()
        .then((offers) => offers.docs.map(Offer.fromSnapshot).toList());
  }

  Future<Offer> findOne(String id) {
    return api.collection('offers').doc(id).get().then(Offer.fromSnapshot);
  }

  Future<void> add(OfferCreateInput offerCreateInput, {File? image}) async {
    StorageImage? storageImage;
    if (image != null) {
      var extension = path.extension(image.path);
      var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      var filePath = 'offers/$timestamp$extension';
      var upload = await storage.ref().child(filePath).putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'), // Set metadata if needed
      );

      storageImage = StorageImage(
        path: filePath,
        size: await image.length(),
        url: await upload.ref.getDownloadURL(),
      );
    }

    api
        .collection('offers')
        .add(offerCreateInput.withImage(storageImage).toJson());
  }

  Future<void> update(
    String id,
    OfferCreateInput data, {
    File? image,
    bool? removeImage,
  }) async {
    final offer = await findOne(id);
    final existingOfferImage = offer.image;
    StorageImage? storageImage = existingOfferImage;

    // delete old file if it exists and is either overridden or removed
    if (existingOfferImage != null && (image != null || removeImage == true)) {
      await FirebaseStorage.instance
          .ref()
          .child(existingOfferImage.path)
          .delete();
      storageImage = null;
    }

    if (image != null) {
      // upload new file
      var extension = path.extension(image.path);
      var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      var filePath = 'offers/$timestamp$extension';
      var upload = await storage.ref().child(filePath).putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'), // Set metadata if needed
      );

      storageImage = StorageImage(
        path: filePath,
        size: await image.length(),
        url: await upload.ref.getDownloadURL(),
      );
    }

    await api
        .collection('offers')
        .doc(id)
        .update(data.withImage(storageImage).toJson());
  }

  Future<void> delete(String id) async {
    final offer = await findOne(id);
    final image = offer.image;
    if (image != null) {
      await storage.ref(image.path).delete();
    }
    await api.collection('offers').doc(id).delete();
  }
}
