import 'package:json_annotation/json_annotation.dart';

part 'objava.g.dart';

@JsonSerializable()
class Objava {
  int? id;
  String? naslov;
  String? sadrzaj;

  Objava(this.id, this.naslov, this.sadrzaj);

  factory Objava.fromJson(Map<String, dynamic> json) => _$ObjavaFromJson(json);

  Map<String, dynamic> toJson() => _$ObjavaToJson(this);
}
