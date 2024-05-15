import 'package:json_annotation/json_annotation.dart';

part 'smjestajna_jedinica.g.dart';

@JsonSerializable()
class SmjestajnaJedinica {
  int? id;
  String? naziv;
  double? cijena;
  int? kapacitet;
  String? opis;
  bool? kuhinja;
  bool? tv;
  bool? klimaUredjaj;
  bool? terasa;
  String? dodatneUsluge;
  int? smjestajId;

  SmjestajnaJedinica(
      this.id,
      this.naziv,
      this.cijena,
      this.kapacitet,
      this.opis,
      this.kuhinja,
      this.tv,
      this.klimaUredjaj,
      this.terasa,
      this.dodatneUsluge,
      this.smjestajId);

  factory SmjestajnaJedinica.fromJson(Map<String, dynamic> json) =>
      _$SmjestajnaJedinicaFromJson(json);

  Map<String, dynamic> toJson() => _$SmjestajnaJedinicaToJson(this);
}
