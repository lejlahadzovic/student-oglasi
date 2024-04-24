import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';

part 'praksa.g.dart';

@JsonSerializable()
class Praksa {
  int? id;
  DateTime? pocetakPrakse;
  DateTime krajPrakse;
  String? kvalifikacije;
  String? benefiti;
  bool? placena;
  Oglas? idNavigation;
  int? statusId;
  StatusOglasi? status;
  int? organizacijaId;
  Organizacije? organizacija;


  Praksa(this.id, this.pocetakPrakse, this.krajPrakse,this.kvalifikacije,this.benefiti,this.placena,this.idNavigation,this.status,this.organizacija);
  factory Praksa.fromJson(Map<String, dynamic> json) => _$PraksaFromJson(json);

  Map<String, dynamic> toJson() => _$PraksaToJson(this);
}