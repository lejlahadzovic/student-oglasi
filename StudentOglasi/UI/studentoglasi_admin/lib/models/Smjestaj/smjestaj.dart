import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Grad/grad.dart';
import 'package:studentoglasi_admin/models/Slike/slike.dart';
import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_admin/models/TipSmjestaja/tip_smjestaja.dart';

part 'smjestaj.g.dart';

@JsonSerializable()
class Smjestaj {
  int? id;
  String? naziv;
  String? adresa;
  String? dodatneUsluge;
  String? opis;
  bool? wiFi;
  bool? parking;
  bool? fitnessCentar;
  bool? restoran;
  bool? uslugePrijevoza;
  Grad? grad;
  TipSmjestaja? tipSmjestaja;
  List<SmjestajnaJedinica>? smjestajnaJedinicas;
  List<String>? slike;
  List<Slike>? slikes;

  Smjestaj(
      this.id,
      this.dodatneUsluge,
      this.naziv,
      this.adresa,
      this.opis,
      this.wiFi,
      this.parking,
      this.fitnessCentar,
      this.restoran,
      this.uslugePrijevoza,
      this.grad,
      this.tipSmjestaja,
      this.smjestajnaJedinicas,
      this.slike,
      this.slikes);

  factory Smjestaj.fromJson(Map<String, dynamic> json) =>
      _$SmjestajFromJson(json);

  Map<String, dynamic> toJson() => _$SmjestajToJson(this);
}
