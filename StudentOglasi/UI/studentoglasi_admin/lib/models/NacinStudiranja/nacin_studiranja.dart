import 'package:json_annotation/json_annotation.dart';

part 'nacin_studiranja.g.dart';

@JsonSerializable()
class NacinStudiranja {
  int? id;
  String? naziv;
  String? opis;

  NacinStudiranja(this.id, this.naziv, this.opis);

  factory NacinStudiranja.fromJson(Map<String, dynamic> json) => _$NacinStudiranjaFromJson(json);

  Map<String, dynamic> toJson() => _$NacinStudiranjaToJson(this);
}
