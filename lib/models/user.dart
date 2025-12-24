import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class DUser {
  final String id;
  final String? uid;
  final String name;
  final String? phoneNumber;
  final Gender? gender;
  final Role role;

  DUser({
    required this.id,
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$DUserToJson(this);

  factory DUser.fromJson(Map<String, dynamic> json) => _$DUserFromJson(json);

  factory DUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return DUser.fromJson({
      "id": snapshot.id,
      ...snapshot.data()!,
    });
  }

  static List<DUser> dummyData() {
    return List.filled(
      3,
      DUser(
        id: '1',
        name: 'name',
        phoneNumber: '+123456789',
        gender: Gender.male,
        role: Role.user,
        uid: '123',
      ),
    );
  }
}

enum Gender {
  male,
  female;

  String get uiName {
    return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  }

  factory Gender.of(String name) {
    if (name == 'male') return Gender.male;
    if (name == 'female') return Gender.female;
    throw ArgumentError("Unrecognized enum name");
  }
}

enum Role { user, admin }

@JsonSerializable(explicitToJson: true)
class DUserInput {
  final String? uid;
  final String name;
  final String? phoneNumber;
  final Gender? gender;
  final Role role;

  DUserInput({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$DUserInputToJson(this);

  factory DUserInput.fromJson(Map<String, dynamic> json) =>
      _$DUserInputFromJson(json);
}
