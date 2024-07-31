import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

part 'komentar.g.dart';

@JsonSerializable()
class Komentar {
  int id;
  int postId;
  ItemType postType;
  int? parentKomentarId;
  DateTime? vrijemeObjave;
  String text;
  String ime;
  String prezime;
  List<Komentar> odgovori;

  Komentar(
    this.id,
    this.postId,
    this.postType,
    this.parentKomentarId,
    this.vrijemeObjave,
    this.text,
    this.ime,
    this.prezime, {
    this.odgovori = const [],
  });

  factory Komentar.fromJson(Map<String, dynamic> json) =>
      _$KomentarFromJson(json);

  Map<String, dynamic> toJson() => _$KomentarToJson(this);
}
