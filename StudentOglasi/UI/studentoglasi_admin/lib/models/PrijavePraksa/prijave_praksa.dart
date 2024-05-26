
import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';

part 'prijave_praksa.g.dart';

@JsonSerializable()
class PrijavePraksa {
  int? studentId;
  int? praksaId;
  String? propratnoPismo;
  String? cv;
  String? certifikati;
  int? statusId;
  Praksa? praksa;
  StatusPrijave? status;
  Student? student;


  PrijavePraksa(this.studentId, this.praksaId, this.propratnoPismo,this.cv,this.certifikati,this.statusId,this.praksa,this.status,this.student);
  factory PrijavePraksa.fromJson(Map<String, dynamic> json) => _$PrijavePraksaFromJson(json);

  Map<String, dynamic> toJson() => _$PrijavePraksaToJson(this);
}
/* {
      "studentId": 1,
      "praksaId": 2,
      "propratnoPismo": "...",
      "cv": "..",
      "certifikati": "...",
      "statusId": 1,
      "praksa": null,
      "status": null,
      "student": null
    }*/
