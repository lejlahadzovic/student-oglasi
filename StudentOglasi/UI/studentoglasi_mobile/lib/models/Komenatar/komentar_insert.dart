import 'package:json_annotation/json_annotation.dart';

part 'komentar_insert.g.dart';

@JsonSerializable()
class KomentarInsert {
  int postId;
  String postType;
  int? parentKomentarId;
  int korisnikId;
  String text;

  KomentarInsert(
    this.postId,
    this.postType,
    this.parentKomentarId,
    this.korisnikId,
    this.text,
  );

  factory KomentarInsert.fromJson(Map<String, dynamic> json) =>
      _$KomentarInsertFromJson(json);

  Map<String, dynamic> toJson() => _$KomentarInsertToJson(this);
}
