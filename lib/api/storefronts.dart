import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Storefronts {
  final api = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  static final instance = Storefronts._();

  Storefronts._();

  Future<List<Storefront>> findMany({
    String? subcategoryId,
    bool? featured,
    int? limit,
  }) {
    Query<Map<String, dynamic>> collection = api.collection('storefronts');
    if (subcategoryId != null) {
      collection = collection.where('subcategory',
          isEqualTo: api.doc('subcategories/$subcategoryId'));
    }
    if (featured != null) {
      collection = collection.where('featured', isEqualTo: featured);
    }
    if (limit != null) {
      collection = collection.limit(limit);
    }
    return collection.get().then((storefronts) =>
        storefronts.docs.map(Storefront.fromSnapshot).toList());
  }

  Future<Storefront> findOne(String id) {
    return api
        .collection('storefronts')
        .doc(id)
        .get()
        .then(Storefront.fromSnapshot);
  }

  Future<void> add(StorefrontCreateInput input, {File? image}) async {
    StorageImage? storageImage;

    try {
      if (image != null && await image.exists()) {
        var extension = path.extension(image.path);
        var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        var filePath = 'storefronts/$timestamp$extension';

        // Reference to storage
        var storageRef = FirebaseStorage.instance.ref().child(filePath);

        // Explicitly set metadata
        SettableMetadata metadata = SettableMetadata(
          contentType:
              'image/${extension.replaceFirst('.', '')}', // Ensures correct file type
        );

        // Upload the file with metadata
        var uploadTask = storageRef.putFile(image, metadata);
        var snapshot = await uploadTask.whenComplete(() => {});

        if (snapshot.state == TaskState.success) {
          var downloadURL = await storageRef.getDownloadURL();
          storageImage = StorageImage(
            path: filePath,
            size: await image.length(),
            url: downloadURL,
          );
        } else {
          throw Exception('Upload failed');
        }
      }

      await api
          .collection('storefronts')
          .add(input.withImage(storageImage).toJson());
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> update(
    String id,
    StorefrontCreateInput data, {
    File? image,
    bool? removeImage,
  }) async {
    final storefront = await findOne(id);
    final existingStorefrontImage = storefront.image;
    StorageImage? storageImage = existingStorefrontImage;

    // delete old file if it exists and is either overridden or removed
    if (existingStorefrontImage != null &&
        (image != null || removeImage == true)) {
      await storage.ref().child(existingStorefrontImage.path).delete();
      storageImage = null;
    }

    if (image != null) {
      try {
        var extension = path.extension(image.path);
        var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        var filePath = 'storefronts/$timestamp$extension';

        // Reference to storage
        var storageRef = storage.ref().child(filePath);

        // Explicitly set metadata
        SettableMetadata metadata = SettableMetadata(
          contentType:
              'image/${extension.replaceFirst('.', '')}', // Ensures correct file type
        );

        // Upload the file with metadata
        var uploadTask = storageRef.putFile(image, metadata);
        var snapshot = await uploadTask.whenComplete(() => {});

        if (snapshot.state == TaskState.success) {
          var downloadURL = await storageRef.getDownloadURL();
          storageImage = StorageImage(
            path: filePath,
            size: await image.length(),
            url: downloadURL,
          );
        } else {
          throw Exception('Upload failed');
        }
      } catch (e) {
        print('Error uploading image: $e');
        throw Exception('Failed to upload image: $e');
      }
    }

    await api
        .collection('storefronts')
        .doc(id)
        .update(data.withImage(storageImage).toJson());
  }

  Future<void> delete(String id) async {
    final storefront = await findOne(id);
    final image = storefront.image;

    if (image != null) {
      await storage.ref(image.path).delete();
    }

    await api.collection('storefronts').doc(id).delete();
  }

  Stream<List<Storefront>> streamStorefronts() {
    return api.collection('storefronts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Storefront.fromSnapshot(doc);
      }).toList();
    });
  }
}
