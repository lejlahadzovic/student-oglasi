import 'package:json_annotation/json_annotation.dart';

part 'kategorija.g.dart';

@JsonSerializable()
class Kategorija {
  int? id;
  String? naziv;
  String? opis;

  Kategorija(this.id, this.naziv, this.opis);

  factory Kategorija.fromJson(Map<String, dynamic> json) => _$KategorijaFromJson(json);

  Map<String, dynamic> toJson() => _$KategorijaToJson(this);
}
