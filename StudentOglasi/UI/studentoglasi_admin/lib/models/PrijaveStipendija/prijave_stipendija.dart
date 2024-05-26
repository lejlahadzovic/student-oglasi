
import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';

part 'prijave_stipendija.g.dart';

@JsonSerializable()
class PrijaveStipendija {
  int? studentId;
  int? stipendijaId;
  String? dokumentacija;
  String? cv;
  double? prosjekOcjena;
  StatusPrijave? status;
  Stipendije? stipendija;
  Student? student;


  PrijaveStipendija(this.studentId, this.stipendijaId, this.dokumentacija,this.cv,this.prosjekOcjena,this.status,this.stipendija,this.student);
  factory PrijaveStipendija.fromJson(Map<String, dynamic> json) => _$PrijaveStipendijaFromJson(json);

  Map<String, dynamic> toJson() => _$PrijaveStipendijaToJson(this);
}
