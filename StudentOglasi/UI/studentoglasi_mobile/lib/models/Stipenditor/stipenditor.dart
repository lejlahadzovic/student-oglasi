
import 'package:json_annotation/json_annotation.dart';

part 'stipenditor.g.dart';

@JsonSerializable()
class Stipenditor {
  int? id;
  String? naziv;
  String? telefon;
  String? email;
  String? adresa;
  String? link;
  int? gradId;


  Stipenditor(this.id, this.naziv, this.telefon,this.email,this.adresa,this.link,this.gradId);
  factory Stipenditor.fromJson(Map<String, dynamic> json) => _$StipenditorFromJson(json);

  Map<String, dynamic> toJson() => _$StipenditorToJson(this);
}
