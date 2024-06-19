// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      (json['id'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnickoIme'] as String?,
      json['email'] as String?,
      json['slika'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'slika': instance.slika,
    };
