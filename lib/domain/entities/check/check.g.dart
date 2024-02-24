// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Check _$CheckFromJson(Map<String, dynamic> json) => Check(
      id: json['id'] as String,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
    );

Map<String, dynamic> _$CheckToJson(Check instance) => <String, dynamic>{
      'id': instance.id,
      'checkedAt': instance.checkedAt.toIso8601String(),
    };
