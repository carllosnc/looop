// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      hour: json['hour'] as String,
      icon: json['icon'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastCheck: json['lastCheck'] == null
          ? null
          : DateTime.parse(json['lastCheck'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'hour': instance.hour,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastCheck': instance.lastCheck?.toIso8601String(),
    };
