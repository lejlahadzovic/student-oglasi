import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? id;
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? email;
  String? slika;

  Korisnik(this.id, this.ime, this.prezime, this.korisnickoIme, this.email, this.slika);

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
