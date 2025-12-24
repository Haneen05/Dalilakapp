// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DUser _$DUserFromJson(Map<String, dynamic> json) => DUser(
      id: json['id'] as String,
      uid: json['uid'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$DUserToJson(DUser instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'gender': _$GenderEnumMap[instance.gender],
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

const _$RoleEnumMap = {
  Role.user: 'user',
  Role.admin: 'admin',
};

DUserInput _$DUserInputFromJson(Map<String, dynamic> json) => DUserInput(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$DUserInputToJson(DUserInput instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'gender': _$GenderEnumMap[instance.gender],
      'role': _$RoleEnumMap[instance.role]!,
    };
