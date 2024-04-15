import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_admin/models/Kategorija/kategorija.dart';

part 'objava.g.dart';

@JsonSerializable()
class Objava {
  int? id;
  String? naslov;
  String? sadrzaj;
  String? slika;
  DateTime? vrijemeObjave;
  int? kategorijaId;
  Kategorija? kategorija;

  Objava(
      this.id, this.naslov, this.sadrzaj,this.slika, this.vrijemeObjave, this.kategorija);

  factory Objava.fromJson(Map<String, dynamic> json) => _$ObjavaFromJson(json);

  Map<String, dynamic> toJson() => _$ObjavaToJson(this);
}
