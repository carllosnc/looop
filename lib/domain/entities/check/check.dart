import 'package:json_annotation/json_annotation.dart';

part 'check.g.dart';

@JsonSerializable(explicitToJson: true)
class Check {
  final String id;
  final DateTime checkedAt;

  Check({
    required this.id,
    required this.checkedAt,
  });

  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);

  Map<String, dynamic> toJson() => _$CheckToJson(this);
}
