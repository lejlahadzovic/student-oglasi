import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';

part 'stipendija.g.dart';

@JsonSerializable()
class Stipendije {
  int? id;
  String? uslovi;
  double? iznos;
  String? kriterij;
  String? potrebnaDokumentacija;
  String? izvor;
  String? nivoObrazovanja;
  int? brojStipendisata;
  Oglas? idNavigation;
  StatusOglasi? status;

  Stipendije(this.id, this.uslovi, this.iznos,this.kriterij,this.potrebnaDokumentacija, this.izvor,this.nivoObrazovanja,this.brojStipendisata,this.idNavigation,this.status);
  factory Stipendije.fromJson(Map<String, dynamic> json) => _$StipendijeFromJson(json);

  Map<String, dynamic> toJson() => _$StipendijeToJson(this);
}