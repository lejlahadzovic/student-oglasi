import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Smjestaj/smjestaj_basic.dart';
import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_admin/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';

part 'rezervacije.g.dart';

@JsonSerializable()
class Rezervacije {
  int? studentId;
  int? smjestajnaJedinicaId;
  DateTime? datumPrijave;
  DateTime? datumOdjave;
  int? brojOsoba;
  String? napomena;
  double? cijena;
  int? statusId;
  SmjestajnaJedinica? smjestajnaJedinica;
  SmjestajBasic? smjestaj;
  StatusPrijave? status;
  Student? student;

  Rezervacije(
      this.studentId,
      this.smjestajnaJedinicaId,
      this.datumPrijave,
      this.datumOdjave,
      this.brojOsoba,
      this.napomena,
      this.cijena,
      this.statusId,
      this.smjestajnaJedinica,
      this.status,
      this.student,
      this.smjestaj);
  factory Rezervacije.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijeToJson(this);
}
