import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Slike/slike.dart';

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
  List<String>? slike;
  List<Slike>? slikes;

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
      this.smjestajId,
      this.slike,
      this.slikes);

  factory SmjestajnaJedinica.fromJson(Map<String, dynamic> json) =>
      _$SmjestajnaJedinicaFromJson(json);

  Map<String, dynamic> toJson() => _$SmjestajnaJedinicaToJson(this);
}
