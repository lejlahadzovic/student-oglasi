import 'package:json_annotation/json_annotation.dart';

part 'tip_smjestaja.g.dart';

@JsonSerializable()
class TipSmjestaja {
  int? id;
  String? naziv;

  TipSmjestaja(this.id, this.naziv);

  factory TipSmjestaja.fromJson(Map<String, dynamic> json) =>
      _$TipSmjestajaFromJson(json);

  Map<String, dynamic> toJson() => _$TipSmjestajaToJson(this);
}
