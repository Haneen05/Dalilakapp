import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

typedef FirestoreDocumentRef = DocumentReference<Map<String, dynamic>>;

class DocumentSerializer
    implements JsonConverter<FirestoreDocumentRef, FirestoreDocumentRef> {
  const DocumentSerializer();

  @override
  FirestoreDocumentRef fromJson(FirestoreDocumentRef docRef) => docRef;

  @override
  FirestoreDocumentRef toJson(FirestoreDocumentRef docRef) => docRef;
}
