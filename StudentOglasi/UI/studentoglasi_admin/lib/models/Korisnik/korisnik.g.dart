// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      json['id'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['kroisnickoIme'] as String?,
      json['email'] as String?,
      json['slika'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'kroisnickoIme': instance.kroisnickoIme,
      'email': instance.email,
      'slika': instance.slika,
    };
