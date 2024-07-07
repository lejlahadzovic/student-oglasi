import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';

import '../Stipenditor/stipenditor.dart';

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
  Stipenditor? stipenditor;

  Stipendije(this.id, this.uslovi, this.iznos,this.kriterij,this.potrebnaDokumentacija, this.izvor,this.nivoObrazovanja,this.brojStipendisata,this.idNavigation,this.status,this.stipenditor);
  factory Stipendije.fromJson(Map<String, dynamic> json) => _$StipendijeFromJson(json);

  Map<String, dynamic> toJson() => _$StipendijeToJson(this);
}