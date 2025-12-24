import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  factory Message.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Message.fromJson({"id": snapshot.id, ...snapshot.data()!});
}

@JsonSerializable(explicitToJson: true)
class MessageInput {
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  MessageInput({
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => _$MessageInputToJson(this);

  factory MessageInput.fromJson(Map<String, dynamic> json) =>
      _$MessageInputFromJson(json);

  factory MessageInput.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      MessageInput.fromJson({"id": snapshot.id, ...snapshot.data()!});
}
