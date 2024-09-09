import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_admin/models/Korisnik/korisnik.dart';
import 'package:studentoglasi_admin/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_admin/models/Smjer/smjer.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  int? id;
  String? brojIndeksa;
  int? godinaStudija;
  double? prosjecnaOcjena;
  bool? status;
  Fakultet? fakultet;
  Korisnik? idNavigation;
  NacinStudiranja? nacinStudiranja;
  Smjer? smjer;

  Student(
      this.id, this.brojIndeksa, this.godinaStudija, this.prosjecnaOcjena, this.status, this.fakultet, this.idNavigation, this.nacinStudiranja, this.smjer);

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
