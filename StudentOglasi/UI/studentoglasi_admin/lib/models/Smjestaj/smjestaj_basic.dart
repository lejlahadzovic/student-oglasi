import 'package:json_annotation/json_annotation.dart';

part 'smjestaj_basic.g.dart';

@JsonSerializable()
class SmjestajBasic {
  int? id;
  String? naziv;
  String? adresa;
  String? opis;
  String? grad;
  String? tipSmjestaja;

  SmjestajBasic(
      this.id,
      this.naziv,
      this.adresa,
      this.opis,
      this.grad,
      this.tipSmjestaja);

  factory SmjestajBasic.fromJson(Map<String, dynamic> json) =>
      _$SmjestajBasicFromJson(json);

  Map<String, dynamic> toJson() => _$SmjestajBasicToJson(this);
}
