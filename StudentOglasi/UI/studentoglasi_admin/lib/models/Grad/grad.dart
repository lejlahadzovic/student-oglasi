import 'package:json_annotation/json_annotation.dart';

part 'grad.g.dart';

@JsonSerializable()
class Grad {
  int? id;
  String? naziv;

  Grad(this.id, this.naziv);

  factory Grad.fromJson(Map<String, dynamic> json) =>
      _$GradFromJson(json);

  Map<String, dynamic> toJson() => _$GradToJson(this);
}
