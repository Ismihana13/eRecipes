// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijest _$ObavijestFromJson(Map<String, dynamic> json) => Obavijest(
      obavijestId: (json['obavijestId'] as num?)?.toInt(),
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>),
      datumSlanja: json['datumSlanja'] == null
          ? null
          : DateTime.parse(json['datumSlanja'] as String),
      procitano: json['procitano'] as bool?,
    );

Map<String, dynamic> _$ObavijestToJson(Obavijest instance) => <String, dynamic>{
      'obavijestId': instance.obavijestId,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumSlanja': instance.datumSlanja?.toIso8601String(),
      'procitano': instance.procitano,
    };
