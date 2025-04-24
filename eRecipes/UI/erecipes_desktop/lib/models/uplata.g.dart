// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uplata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uplata _$UplataFromJson(Map<String, dynamic> json) => Uplata()
  ..uplataId = (json['uplataId'] as num?)?.toInt()
  ..iznos = (json['iznos'] as num?)?.toDouble()
  ..korisnikId = (json['korisnikId'] as num?)?.toInt()
  ..datumUplate = json['datumUplate'] == null
      ? null
      : DateTime.parse(json['datumUplate'] as String)
  ..korisnik = json['korisnik'] == null
      ? null
      : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$UplataToJson(Uplata instance) => <String, dynamic>{
      'uplataId': instance.uplataId,
      'iznos': instance.iznos,
      'korisnikId': instance.korisnikId,
      'datumUplate': instance.datumUplate?.toIso8601String(),
      'korisnik': instance.korisnik,
    };
