import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class AppError {
  @JsonKey(name: 'error_message')
  String? message;

  @JsonKey(name: 'error_type')
  String? errorType;

  AppError({
    this.message,
    this.errorType,
  });

  @override
  String toString() => message ?? '';

  factory AppError.fromJson(Map<String, dynamic> json) => _$AppErrorFromJson(json);
  Map<String, dynamic> toJson() => _$AppErrorToJson(this);
}
