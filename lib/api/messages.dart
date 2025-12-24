import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models/message.dart';

class Messages {
  final api = FirebaseFirestore.instance;

  static final instance = Messages._();

  Messages._();

  Future<void> add(MessageInput data) async {
    await api.collection('messages').add(data.toJson());
  }
}
