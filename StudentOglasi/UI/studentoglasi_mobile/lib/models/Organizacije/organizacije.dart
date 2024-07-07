
import 'package:json_annotation/json_annotation.dart';

part 'organizacije.g.dart';

@JsonSerializable()
class Organizacije {
  int? id;
  String? naziv;
  String? telefon;
  String? email;
  String? adresa;
  String? link;

  Organizacije(this.id, this.naziv, this.telefon,this.email,this.adresa,this.link);
  factory Organizacije.fromJson(Map<String, dynamic> json) => _$OrganizacijeFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizacijeToJson(this);
}