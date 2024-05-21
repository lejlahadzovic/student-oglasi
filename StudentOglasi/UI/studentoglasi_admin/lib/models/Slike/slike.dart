import 'package:json_annotation/json_annotation.dart';

part 'slike.g.dart';

@JsonSerializable()
class Slike {
  int? id;
  String? naziv;
  int? smjestajId;
  int? smjestajnaJedinicaId;

  Slike(this.id, this.naziv, this.smjestajId, this.smjestajnaJedinicaId);

  factory Slike.fromJson(Map<String, dynamic> json) => _$SlikeFromJson(json);

  Map<String, dynamic> toJson() => _$SlikeToJson(this);
}
