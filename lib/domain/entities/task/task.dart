import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  final String id;
  final String title;
  final String icon;
  final String hour;
  final DateTime createdAt;
  final DateTime? lastCheck;

  Task({
    required this.id,
    required this.title,
    required this.hour,
    required this.icon,
    required this.createdAt,
    this.lastCheck,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
