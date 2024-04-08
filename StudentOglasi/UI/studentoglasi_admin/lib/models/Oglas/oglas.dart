import 'package:json_annotation/json_annotation.dart';

part 'oglas.g.dart';

@JsonSerializable()
class Oglas {
  int? id;
  String? naslov;
  DateTime? rokPrijave;
  String? opis;
  DateTime? vrijemeObjave;
  String? slika;
  
  Oglas(this.id, this.naslov, this.rokPrijave,this.opis,this.vrijemeObjave,this.slika);
  factory Oglas.fromJson(Map<String, dynamic> json) => _$OglasFromJson(json);

  Map<String, dynamic> toJson() => _$OglasToJson(this);
}